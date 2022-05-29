from typing import List
from pydantic.main import BaseModel

from .ingredient import Ingredient

class Recipe(BaseModel):
    name: str
    ingredients: List[Ingredient]
    preparation_time_sec: int
    preparation_method: str
