from sqlalchemy.orm import Session
import sqlalchemy

from backend.src.domain.ports.recipe_tag_repository import Recipe_TagRepository

from backend.src.domain.entities.recipe_tag import Recipe_Tag

import backend.src.interface.database.models as models

class Recipe_TagRepositoryImpl(Recipe_TagRepository):

    async def create(self, db: Session, recipeid: int, relation: Recipe_Tag) -> Recipe_Tag:
        db_item = models.Recipe_Tag(id_recipe=recipeid, id_tag=relation.id_tag)

        db.add(db_item)
        db.commit()
        db.refresh(db_item)
        return db_item

    async def delete_all_by_recipe(self, db: Session, recipeid: int):
        db.query(models.Recipe_Tag).filter(models.Recipe_Tag.id_recipe==recipeid).delete()

        db.commit()
