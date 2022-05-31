from fastapi import FastAPI, Depends, HTTPException, Request, status, Path
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from fastapi.middleware.cors import CORSMiddleware
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic.main import BaseModel
from sqlalchemy.orm import Session

from datetime import datetime, timedelta
from backend.src.interface.database.database import SessionLocal, engine
from backend.src.interface.database.models import Base
from backend.src.adapters.repository.recipe_repository import RecipeRepositoryImpl
from backend.src.adapters.repository.user_repository import UserRepositoryImpl

from backend.src.domain.entities.user import User
from backend.src.domain.entities.recipe import Recipe

from backend.src.interface.database.user_model import UserModel

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
RecipeRepository = RecipeRepositoryImpl()

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

    user = await UserRepository.get_by_name(db,name=token_data.username)
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

    UserRepository.create(db, user.username, user.email, hashed_password)
    return user

@app.get("/recipe/{recipe_id}")
async def get_recipe(
        recipe_id: int = Path(title="The ID of the item to get", ge=1),
        current_user: User = Depends(get_current_user),
        db: Session = Depends(get_db)
):
    recipe = await RecipeRepository.get(db, recipe_id)
    recipe.ingredients
    recipe.tags
    return recipe

@app.post("/recipe/")
async def register_recipe(recipe: Recipe, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    return await RecipeRepository.create(db, recipe, current_user)

@app.put("/recipe/{recipe_id}")
async def update_recipe(
        recipe: Recipe,
        recipe_id: int = Path(title="The ID of the item to update", ge=1),
        current_user: User = Depends(get_current_user)
):
    return await RecipeRepository.update(recipe)

