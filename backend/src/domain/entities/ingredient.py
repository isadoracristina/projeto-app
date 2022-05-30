from typing import List
from pydantic import BaseModel

from .recipe_ingredient import Recipe_Ingredient

class Ingredient(BaseModel):
    id: int
    name: str
    recipes: List[Recipe_Ingredient]

    class Config:
        orm_mode = True
