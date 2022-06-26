from typing import List
from backend.src.adapters.repository.tag_repository import TagRepositoryImpl
from backend.src.domain.entities.tag import Tag
from backend.src.domain.entities.user import User


class TagService():
    def __init__(self):
        self.tag_repo = TagRepositoryImpl()

    async def register_tag(self, tag: Tag, db) -> Tag:
        return await self.tag_repo.create(db, tag)

    async def get_tag(self, tag_id: int, user: User, db) -> Tag:
        return await self.tag_repo.get(db, tag_id)

    async def get_all_tags(self, user: User, db) -> List[Tag]:
        return await self.tag_repo.get_all(db)

