from unicodedata import name
import sqlalchemy
from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func
from typing import List
import datetime

from backend.src.domain.ports.recipe_repository import RecipeRepository
from .recipe_ingredient_repository import Recipe_IngredientRepositoryImpl
from .recipe_tag_repository import Recipe_TagRepositoryImpl

from backend.src.interface.database.fake_db import RECIPES as FakeDB_Recipes

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.user import User
from backend.src.domain.entities.ingredient import Ingredient

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

ingred_repo = Recipe_IngredientRepositoryImpl()
tag_repo = Recipe_TagRepositoryImpl()

class RecipeRepositoryImpl(RecipeRepository):
    async def get(self, db: Session, id: int) -> models.Recipe:
        return db.query(models.Recipe).filter(models.Recipe.id_recipe == id).first()

    async def create(self, db: Session, recipe: Recipe, user: models.User) -> models.Recipe:
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
        
        for i in recipe.ingredients:
            await ingred_repo.create(db, new_id, i)
        for t in recipe.tags:
            await tag_repo.create(db, new_id, t)

        return db_item

    async def update(self, db: Session, recipeid: int, recipe: Recipe) -> None:
        db.execute(sqlalchemy.update(models.Recipe).
                              where(models.Recipe.id_recipe == recipeid).
                              values(name_recipe=recipe.name, img_addr=recipe.img_addr,
                                     prep_time=recipe.preparation_time_sec, prep_method= recipe.preparation_method,
                                     rating=recipe.rating, observation=recipe.observation,
                                     pantry_only=recipe.pantry_only))
        
        db.commit()

        await ingred_repo.delete_all_by_recipe(db, recipeid)
        await tag_repo.delete_all_by_recipe(db, recipeid)

        for i in recipe.ingredients:
            await ingred_repo.create(db, recipeid, i)
        for t in recipe.tags:
            await tag_repo.create(db, recipeid, t)

    async def get_all(self, db: Session, user_id: int) -> List[models.Recipe]:
        return db.query(models.Recipe).filter(models.Recipe.id_user == user_id).all()