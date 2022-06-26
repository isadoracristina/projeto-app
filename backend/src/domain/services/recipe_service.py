from typing import Union, List

from datetime import datetime

from backend.src.domain.entities.recipe_ingredient import Recipe_Ingredient
from backend.src.domain.entities.recipe_tag import Recipe_Tag

from sqlalchemy.sql.functions import current_user
from backend.src.adapters.repository.ingredient_repository import IngredientRepositoryImpl
from backend.src.adapters.repository.tag_repository import TagRepositoryImpl
from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.user import User

from backend.src.adapters.repository.recipe_repository import RecipeRepositoryImpl
from pydantic.main import BaseModel
class IngredientNameMeasure(BaseModel):
    id: int
    name: str
    amount: float
    measurement: str

class RecipeGet(BaseModel):
    id: int
    id_user: int
    name: str
    img_addr: Union[str, None]
    preparation_time_sec: int
    preparation_method: str
    rating: float
    observation: str
    last_made: Union[datetime, None]
    pantry_only: bool
    ingredients: List[Recipe_Ingredient]
    tags: List[Recipe_Tag]
    ingredients_names: list
    tags_names: list

class RecipeService():
    def __init__(self) -> None:
        self.tag_repo = TagRepositoryImpl()
        self.ing_repo = IngredientRepositoryImpl()
        self.recipe_repo = RecipeRepositoryImpl()

    async def register_recipe(self, recipe: Recipe, user: User, db) -> Recipe:
        return await self.recipe_repo.create(db, recipe, user);

    async def update_recipe(self, recipe: Recipe, recipe_id: int, user: User, db) -> Recipe:
        return await self.recipe_repo.update(db, recipe_id, recipe);

    async def get_recipe(self, recipe_id: int, user: User, db) -> Recipe:
            recipe_model = await self.recipe_repo.get(db, recipe_id)

            list_ing_names = []
            list_tag_names = []
            for r in recipe_model.ingredients:
                i = await self.ing_repo.get(db, r.id_ingredient)
                i_name = IngredientNameMeasure(id=i.id_ingredient, name=i.name_ingredient, amount=r.amount, measurement=r.measurement)
                list_ing_names.append(i_name)

            for r in recipe_model.tags:
                t = await self.tag_repo.get(db, r.id_tag)
                list_tag_names.append(t)

                recipe = RecipeGet(id=recipe_model.id_recipe, id_user=recipe_model.id_user,
                       name=recipe_model.name_recipe, img_addr=recipe_model.img_addr,
                       preparation_time_sec=recipe_model.prep_time, preparation_method= recipe_model.prep_method,
                       rating=recipe_model.rating, observation=recipe_model.observation,
                       last_made=recipe_model.last_made, pantry_only=recipe_model.pantry_only,
                       ingredients=recipe_model.ingredients, tags=recipe_model.tags,
                       ingredients_names= list_ing_names, tags_names=list_tag_names)

            return recipe

    async def get_all_recipes(self, user: User, db) -> List[Recipe]:
        list_recipes = []
        for recipe_model in await self.recipe_repo.get_all(db, user_id=current_user.id_user):
            list_ing_names = []
            list_tag_names = []
            for r in recipe_model.ingredients:
                i = await self.ing_repo.get(db, r.id_ingredient)
                i_name = IngredientNameMeasure(id=i.id_ingredient, name=i.name_ingredient, amount=r.amount, measurement=r.measurement)
                list_ing_names.append(i_name)
            for r in recipe_model.tags:
                t = await self.tag_repo.get(db, r.id_tag)
                list_tag_names.append(t)

            recipe = RecipeGet(id=recipe_model.id_recipe, id_user=recipe_model.id_user,
                    name=recipe_model.name_recipe, img_addr=recipe_model.img_addr,
                    preparation_time_sec=recipe_model.prep_time, preparation_method= recipe_model.prep_method,
                    rating=recipe_model.rating, observation=recipe_model.observation,
                    last_made=recipe_model.last_made, pantry_only=recipe_model.pantry_only,
                    ingredients=recipe_model.ingredients, tags=recipe_model.tags,
                    ingredients_names= list_ing_names, tags_names=list_tag_names)
            list_recipes.append(recipe)

        return list_recipes







