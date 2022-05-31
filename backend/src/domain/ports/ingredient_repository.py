from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session
from typing import List

from backend.src.domain.entities.ingredient import Ingredient

class IngredientRepository(Protocol):
    async def get(self, db: Session, ingredient_id: int) -> Ingredient: ...
    async def create(self, db: Session, ingredient: Ingredient) -> Ingredient: ...
    async def get_all(self, db: Session) -> List[Ingredient]: ...
