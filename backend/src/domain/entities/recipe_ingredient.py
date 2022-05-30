from pydantic import BaseModel

class Recipe_Ingredient(BaseModel):
    id_recipe: int
    id_ingredient: int
    amount: float
    measurement: str
    

    class Config:
        orm_mode = True