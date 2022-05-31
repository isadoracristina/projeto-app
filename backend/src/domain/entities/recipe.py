from typing import List, Union
from pydantic.main import BaseModel
import datetime

from .recipe_ingredient import Recipe_Ingredient
from .recipe_tag import Recipe_Tag

class Recipe(BaseModel):
    id: int
    id_user: int
    name: str
    img_addr: str
    preparation_time_sec: int
    preparation_method: str
    rating: float
    observation: str
    last_made: Union[datetime.datetime, None]
    pantry_only: bool
    ingredients: List[Recipe_Ingredient]
    tags: List[Recipe_Tag]

    class Config:
        orm_mode = True
