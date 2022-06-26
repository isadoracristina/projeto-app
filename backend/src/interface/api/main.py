from typing import List, Union
from fastapi import FastAPI, Depends, HTTPException, Request, status, Path
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic.main import BaseModel
from sqlalchemy.orm import Session

from datetime import datetime, timedelta

from sqlalchemy.sql.functions import current_user
from backend.src.domain.services.ingredient_service import IngredientService
from backend.src.interface.database.database import SessionLocal, engine
from backend.src.interface.database.models import Base
import backend.src.interface.database.models as models
from backend.src.adapters.repository.recipe_repository import RecipeRepositoryImpl
from backend.src.adapters.repository.user_repository import UserRepositoryImpl
from backend.src.adapters.repository.ingredient_repository import IngredientRepositoryImpl
from backend.src.adapters.repository.tag_repository import TagRepositoryImpl

from backend.src.domain.entities.user import User
from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.recipe_ingredient import Recipe_Ingredient
from backend.src.domain.entities.recipe_tag import Recipe_Tag
from backend.src.domain.entities.ingredient import Ingredient
from backend.src.domain.entities.tag import Tag

from backend.src.interface.database.user_model import UserModel

from backend.src.domain.services.ingredient_service import IngredientService
from backend.src.domain.services.tag_service import TagService
from backend.src.domain.services.recipe_service import RecipeService
from backend.src.domain.services.filter_service import FilterService

app = FastAPI()
Base.metadata.create_all(bind=engine)

origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)


UserRepository = UserRepositoryImpl()

RecipeService = RecipeService()
TagService = TagService()
IngredientService = IngredientService()

SECRET_KEY = "feb5eb835a3fff5567272d7ddfd93c0c28c7151a38c04fc6d5d65aece6a10f66"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: str | None = None

class UserRegister(BaseModel):
    username: str
    email: str
    password: str

class IngredientNameMeasure(BaseModel):
    id: int
    name: str
    amount: float
    measurement: str

class RecipeGet(BaseModel):
    id: int
    id_user: int
    name: str
    img_addr: Union[str, None]
    preparation_time_sec: int
    preparation_method: str
    rating: float
    observation: str
    last_made: Union[datetime, None]
    pantry_only: bool
    ingredients: List[Recipe_Ingredient]
    tags: List[Recipe_Tag]
    ingredients_names: list
    tags_names: list

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

async def authenticate_user(username: str, password: str, db):
    user = await UserRepository.get_by_name(db, name=username)
    if not user:
        return False
    if not verify_password(password, user.hash_psswd):
        return False
    return user

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)

    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

@app.get("/")
async def root():
    return {"message": "Hello World"}

async def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception

        token_data = TokenData(username=username)

    except JWTError:
        raise credentials_exception

    user = await UserRepository.get_by_name(db,name=str(token_data.username))
    if user is None:
        raise credentials_exception

    return user

@app.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = await authenticate_user(form_data.username, form_data.password, db)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"}
        )

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.name_user}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "Bearer"}

@app.post("/user/")
async def register_user(user: UserRegister, db: Session = Depends(get_db)):
    hashed_password = get_password_hash(user.password)

    user_created = UserRepository.create(db, user.username, user.email, hashed_password)
    return user_created

@app.get("/user/me")
async def get_user(
        current_user: User = Depends(get_current_user)
):
    return current_user


@app.get("/recipe/{recipe_id}")
async def get_recipe(
        recipe_id: int = Path(title="The ID of the item to get", ge=1),
        current_user: User = Depends(get_current_user),
        db: Session = Depends(get_db)
):
    return await RecipeService.get_recipe(recipe_id, current_user, db)

@app.post("/recipe/")
async def register_recipe(recipe: Recipe, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    return await RecipeService.register_recipe(recipe, current_user, db)

@app.put("/recipe/{recipe_id}")
async def update_recipe(
        recipe: Recipe,
        recipe_id: int = Path(title="The ID of the item to update", ge=1),
        current_user: User = Depends(get_current_user),
        db: Session = Depends(get_db)
):
    return await RecipeService.update_recipe(recipe, recipe_id, current_user,  db)

@app.get("/recipe/")
async def get_all_recipes(
        current_user: models.User = Depends(get_current_user),
        db: Session = Depends(get_db)
):

    return await RecipeService.get_all_recipes(current_user, db)

@app.get("/ingredient/{ingredient_id}")
async def get_ingredient(
    ingredient_id: int = Path(title="The ID of the item to get", ge=1),
    currrent_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return await IngredientService.get_ingredient(ingredient_id, db)


@app.post("/ingredient/")
async def register_ingredient(
    ingredient: Ingredient,
    db: Session = Depends(get_db)
):

    return await IngredientService.register_ingredient(db, ingredient)

@app.get("/ingredient/")
async def get_all_ingredients(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return await IngredientService.get_all_ingredients(db)

@app.get("/tag/{tag_id}")
async def get_tag(
    tag_id: int = Path(title="The ID of the item to get", ge=1),
    currrent_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
) -> Tag:

    return await TagService.get_tag(tag_id, current_user, db)

@app.post("/tag/")
async def register_tag(
    tag: Tag,
    db: Session = Depends(get_db)
) -> Tag:

    return await TagService.register_tag(tag, db)

@app.get("/tag/")
async def get_all_tags(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    return await TagService.get_all_tags(current_user, db)

@app.post("/recipe/filter/ingredient/")
async def get_filtered_recipes_by_ingredient(
        ingredients: List[Ingredient],
        current_user: User = Depends(get_current_user),
        recipes: List[Recipe] = Depends(get_all_recipes),
        db: Session = Depends(get_db)
):

    filter_service = FilterService()
    return filter_service.filter_by_ingredient(recipes, ingredients)

@app.post("/recipe/filter/tag/")
async def get_filtered_recipes_by_tag(
        tags: List[Tag],
        current_user: User = Depends(get_current_user),
        recipes: List[Recipe] = Depends(get_all_recipes),
        db: Session = Depends(get_db)
):

    filter_service = FilterService()
    return filter_service.filter_by_tag(recipes, tags)


