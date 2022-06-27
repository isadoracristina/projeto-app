import pytest

from backend.src.adapters.repository.user_repository import UserRepositoryImpl
from backend.src.domain.entities.tag import Tag
from backend.src.domain.entities.user import User

from backend.src.interface.database.models import Base

from backend.src.domain.services.tag_service import TagService
from backend.src.interface.database.database import SessionLocal, engine

dummy_tag = Tag(id=1,
                   description = "test",
                   recipes = [])

@pytest.fixture
def tag_service():
    return TagService()

db = SessionLocal()

@pytest.fixture
def database():
    Base.metadata.create_all(bind=engine)
    yield
    Base.metadata.drop_all(bind=engine)

@pytest.fixture
@pytest.mark.asyncio
async def user(database):
    user_repo = UserRepositoryImpl()
    user_repo.create(db, "tester", "tester@tester.com", "1234")
    return await user_repo.get_by_name(db, "tester")

@pytest.mark.asyncio
class TestTagService():
    async def test_new_empty(self, tag_service: TagService, user, database):
        tags = await tag_service.get_all_tags(user, db)
        assert len(tags) == 0

    async def test_new_tag(self, tag_service: TagService, user, database):
        await tag_service.register_tag(dummy_tag, db)
        tags = await tag_service.get_all_tags(user, db)
        assert len(tags) == 1

    async def test_get_tag_when_empty(self, tag_service: TagService, user, database):
        tag = await tag_service.get_tag(1, user, db)
        assert tag is None

    async def test_get_tag(self, tag_service: TagService, user, database):
        await tag_service.register_tag(dummy_tag, db)
        tag = await tag_service.get_tag(1, user, db)
        assert tag is not None
