from fastapi import FastAPI, Depends, HTTPException, Request, status, Path
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from jose import JWTError, jwt
from passlib.context import CryptContext
from pydantic.main import BaseModel

from datetime import datetime, timedelta
from backend.src.adapters.repository.recipe_repository import RecipeRepositoryImpl
from backend.src.adapters.repository.user_repository import UserRepositoryImpl

from backend.src.domain.entities.user import User
from backend.src.domain.entities.recipe import Recipe

from backend.src.interface.database.user_model import UserModel

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
    password: str

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

async def authenticate_user(username: str, password: str):
    user = await UserRepository.get_by_name(name=username)
    if not user:
        return False
    if not verify_password(password, user.hashed_password):
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

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

async def get_current_user(token: str = Depends(oauth2_scheme)):
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

    user = UserRepository.get_by_name(name=token_data.username)
    if user is None:
        raise credentials_exception

    return user

@app.post("/token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"}
        )

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.name}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "Bearer"}

@app.post("/user/")
async def register_user(user: UserRegister):
    hashed_password = get_password_hash(user.password)

    await UserRepository.create(user.username, hashed_password)
    return user

@app.get("/recipe/{recipe_id}")
async def get_recipe(
        recipe_id: int = Path(title="The ID of the item to update", ge=1),
        current_user: User = Depends(get_current_user)
):
    return await RecipeRepository.get(recipe_id)

@app.post("/recipe/")
async def register_recipe(recipe: Recipe, current_user: User = Depends(get_current_user)):
    return await RecipeRepository.create(recipe)

@app.put("/recipe/{recipe_id}")
async def update_recipe(
        recipe: Recipe,
        recipe_id: int = Path(title="The ID of the item to update", ge=1),
        current_user: User = Depends(get_current_user)
):
    return await RecipeRepository.update(recipe)

