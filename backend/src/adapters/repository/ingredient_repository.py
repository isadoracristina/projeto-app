from sqlalchemy.orm import Session

from backend.src.domain.ports.ingredient_repository import IngredientRepository

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class IngredientRepositoryImpl(IngredientRepository):
    async def get(self, db: Session, id: int):
        return db.query(models.Ingredient).filter(models.Ingredient.id_ingredient == id).first()
        
    async def get_by_name(self, db: Session, name: str):
        return db.query(models.Ingredient).filter(models.Ingredient.name_ingredient == name).first()

    async def get_all(self, db: Session):
        return db.query(models.Ingredient).all()