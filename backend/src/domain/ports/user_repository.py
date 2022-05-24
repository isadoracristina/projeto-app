from pydantic import BaseModel
from typing import Protocol

from backend.src.domain.entities.user import User

class UserRepository(Protocol):
    async def get(self, id: int) -> User: ...
    async def get_by_name(self, name: str) -> User: ...
