from backend.src.domain.entities.recipe import Recipe
import datetime

class RecipeModel(Recipe):
    date_registered: datetime.datetime