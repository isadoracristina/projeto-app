from pydantic import BaseModel
from .recipe import Recipe
from typing import List

class User(BaseModel):
    id: int
    name: str
    email: str
    recipes: List[Recipe]

    class Config:
        orm_mode = True
