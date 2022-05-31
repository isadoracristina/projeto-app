from sqlalchemy.orm import Session

from backend.src.domain.ports.tag_repository import TagRepository

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class TagRepositoryImpl(TagRepository):
    async def get(self, db: Session, id: int):
        return db.query(models.Tag).filter(models.Tag.id_tag == id).first()
        
    async def get_by_name(self, db: Session, name: str):
        return db.query(models.Tag).filter(models.Tag.description_tag == name).first()

    async def get_all(self, db: Session):
        return db.query(models.Ingredient).all()
