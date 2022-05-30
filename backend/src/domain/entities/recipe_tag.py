from pydantic import BaseModel

class Recipe_Tag(BaseModel):
    id_recipe: int
    id_tag: int

    class Config:
        orm_mode = True