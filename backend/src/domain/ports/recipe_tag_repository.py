from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.recipe_tag import Recipe_Tag

class Recipe_TagRepository(Protocol):
    async def create(self, db: Session, recipe: Recipe_Tag) -> Recipe_Tag: ...