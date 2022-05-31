from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func
import datetime

from backend.src.domain.ports.recipe_ingredient_repository import Recipe_IngredientRepository

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.recipe_ingredient import Recipe_Ingredient
from backend.src.domain.entities.user import User
from backend.src.domain.entities.ingredient import Ingredient

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class Recipe_IngredientRepositoryImpl(Recipe_IngredientRepository):

    async def create(self, db: Session, recipeid: int, relation: Recipe_Ingredient) -> Recipe_Ingredient:
        new_id = SessionLocal().query(func.max(models.Recipe.id_recipe)).scalar()
        if new_id == None:
            new_id = 1
        else:
            new_id += 1
        db_item = models.Recipe_Ingredient(id_recipe=relation.id_recipe, id_ingredient=relation.id_ingredient,
                                           amount=relation.amount, measurement=relation.measurement)

        db.add(db_item)
        db.commit()
        db.refresh(db_item)
        return db_item