from pydantic import BaseModel
import datetime
from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func
from typing import List

from backend.src.domain.ports.ingredient_repository import IngredientRepository

from backend.src.domain.entities.ingredient import Ingredient

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class IngredientRepositoryImpl(IngredientRepository):
    async def get(self, db: Session, ingredient_id: int):
        return db.query(models.Ingredient).filter(models.Ingredient.id_ingredient == ingredient_id).first()

    async def create(self, db: Session, ingredient: Ingredient) -> Ingredient:
        new_id = SessionLocal().query(func.max(models.Ingredient.id_ingredient)).scalar()
        if new_id == None:
            new_id = 1
        else:
            new_id += 1
        db_item = models.Ingredient(id_ingredient=new_id, name_ingredient=ingredient.name)

        db.add(db_item)
        db.commit()
        db.refresh(db_item)

        return db_item
    
    async def get_all(self, db: Session) -> List[Ingredient]:
        return db.query(models.Ingredient).all()
