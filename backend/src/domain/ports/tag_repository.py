from pydantic import BaseModel
from typing import Protocol
from sqlalchemy.orm import Session

from backend.src.domain.entities.tag import Tag

class TagRepository(Protocol):
    async def get(self, db: Session, id: int) -> Tag: ...
    async def get_by_name(self, db: Session, name: str) -> Tag: ...
    async def get_all(self, db: Session) -> Tag: ...