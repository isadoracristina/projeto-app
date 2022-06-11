from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.recipe_ingredient import Recipe_Ingredient

class Recipe_IngredientRepository(Protocol):
    async def create(self, db: Session, recipeid: int, recipe: Recipe_Ingredient) -> Recipe_Ingredient: ...
    async def delete_all_by_recipe(self, db: Session, recipeid: int): ...
