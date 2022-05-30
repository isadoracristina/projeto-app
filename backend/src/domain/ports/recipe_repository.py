from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.recipe import Recipe

class RecipeRepository(Protocol):
    async def get(self, db: Session, id: int) -> Recipe: ...
    async def create(self, db: Session, recipe: Recipe) -> Recipe: ...
    async def update(self, db: Session, recipe: Recipe) -> Recipe: ...
