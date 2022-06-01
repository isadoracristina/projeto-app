from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from backend.src.domain.ports.tag_repository import TagRepository

from backend.src.domain.entities.tag import Tag

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class TagRepositoryImpl(TagRepository):
    async def get(self, db: Session, id: int):
        return db.query(models.Tag).filter(models.Tag.id_tag == id).first()
        
    async def get_by_name(self, db: Session, name: str):
        return db.query(models.Tag).filter(models.Tag.description_tag == name).first()

    async def get_all(self, db: Session):
        return db.query(models.Tag).all()

    async def create(self, db: Session, tag: Tag) -> Tag:
        new_id = SessionLocal().query(func.max(models.Tag.id_tag)).scalar()
        if new_id == None:
            new_id = 1
        else:
            new_id += 1
        db_item = models.Tag(id_tag=new_id, description_tag=tag.description)

        db.add(db_item)
        db.commit()
        db.refresh(db_item)

        return db_item
