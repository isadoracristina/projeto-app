from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.ingredient import Ingredient

class IngredientRepository(Protocol):
    async def get(self, db: Session, id: int) -> Ingredient: ...
    async def get_by_name(self, db: Session, name: str) -> Ingredient: ...
    async def get_all(self, db: Session) -> Ingredient: ...