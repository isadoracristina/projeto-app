from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.recipe_ingredient import Recipe_Ingredient

class Recipe_IngredientRepository(Protocol):
    async def create(self, db: Session, recipe: Recipe_Ingredient) -> Recipe_Ingredient: ...