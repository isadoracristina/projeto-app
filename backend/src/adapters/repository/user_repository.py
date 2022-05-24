from pydantic import BaseModel
from typing import Protocol

from backend.src.domain.entities.user import User
from backend.src.domain.ports.user_repository import UserRepository

from backend.src.interface.database.fake_db import USERS as FakeDB_Users
from backend.src.interface.database.user_model import UserModel

class UserRepositoryImpl(UserRepository):
    async def get(self, id: int) -> User:
        raise NotImplementedError

    async def get_by_name(self, name: str) -> User:
        if name in FakeDB_Users:
            user_dict = FakeDB_Users[name]
            return UserModel(**user_dict)

