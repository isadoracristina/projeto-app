from pydantic import BaseModel
from typing import List

from .recipe_tag import Recipe_Tag

class Tag(BaseModel):
    id: int
    description: str
    recipes: List[Recipe_Tag] = []

    class Config:
        orm_mode = True