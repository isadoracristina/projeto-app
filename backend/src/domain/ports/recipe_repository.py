from pydantic import BaseModel
from typing import Protocol, List
from sqlalchemy.orm import Session

from backend.src.domain.entities.recipe import Recipe
import backend.src.interface.database.models as models

class RecipeRepository(Protocol):
    async def get(self, db: Session, id: int) -> models.Recipe: ...
    async def create(self, db: Session, recipe: Recipe) -> models.Recipe: ...
    async def update(self, db: Session, recipeid: int, recipe: Recipe) -> models.Recipe: ...
    async def get_all(self, db: Session, user_id: int) -> List[models.Recipe]: ...