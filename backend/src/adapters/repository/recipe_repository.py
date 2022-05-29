from pydantic import BaseModel

from backend.src.domain.ports.recipe_repository import RecipeRepository

from backend.src.interface.database.fake_db import RECIPES as FakeDB_Recipes

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.ingredient import Ingredient

class RecipeRepositoryImpl(RecipeRepository):
    async def get(self, id: int) -> Recipe:
        if id in FakeDB_Recipes:
            recipe_dict = FakeDB_Recipes[id]
            ingredients = [Ingredient(name=x) for x in recipe_dict["ingredients"]]
            recipe_dict["ingredients"] = ingredients
            return Recipe(**recipe_dict, id=id)

    async def create(self, recipe: Recipe) -> Recipe:
        id = len(FakeDB_Recipes)
        FakeDB_Recipes[id] = vars(recipe)
        FakeDB_Recipes[id].update({"id": id})
        return FakeDB_Recipes[id]

    async def update(self, recipe: Recipe) -> Recipe:
        if recipe.id not in FakeDB_Recipes:
            return NotImplementedError

        elif recipe.id == 0:
            return NotImplementedError

        ingredients = [x.name for x in recipe.ingredients]
        FakeDB_Recipes[recipe.id] = vars(recipe)
        FakeDB_Recipes[recipe.id]["ingredients"] = ingredients
        del FakeDB_Recipes[recipe.id]["id"]
        return recipe

