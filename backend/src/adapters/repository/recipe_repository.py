from unicodedata import name
from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func
import datetime
from sqlalchemy import insert, delete

from backend.src.domain.ports.recipe_repository import RecipeRepository

from backend.src.interface.database.fake_db import RECIPES as FakeDB_Recipes

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.user import User
from backend.src.domain.entities.ingredient import Ingredient

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class RecipeRepositoryImpl(RecipeRepository):
    async def get(self, db: Session, id: int) -> Recipe:
        return db.query(models.Recipe).filter(models.Recipe.id_recipe == id).first()

    async def create(self, db: Session, recipe: Recipe, user: User) -> Recipe:
        new_id = SessionLocal().query(func.max(models.Recipe.id_recipe)).scalar()
        if new_id == None:
            new_id = 1
        else:
            new_id += 1
        db_item = models.Recipe(id_recipe=new_id, id_user=user.id_user, name_recipe=recipe.name,
                                img_addr=recipe.img_addr, prep_time=recipe.preparation_time_sec,
                                prep_method=recipe.preparation_method, rating=recipe.rating,
                                observation=recipe.observation, last_made=None,
                                date_registered=datetime.datetime.now(), pantry_only=recipe.pantry_only)
        db.add(db_item)
        db.commit()
        db.refresh(db_item)
        return db_item

    async def update(self, db: Session, recipe: Recipe) -> Recipe:
        if recipe.id not in FakeDB_Recipes:
            return NotImplementedError

        elif recipe.id == 0:
            return NotImplementedError

        ingredients = [x.name for x in recipe.ingredients]
        FakeDB_Recipes[recipe.id] = vars(recipe)
        FakeDB_Recipes[recipe.id]["ingredients"] = ingredients
        del FakeDB_Recipes[recipe.id]["id"]
        return recipe

