import pytest

from backend.src.adapters.repository.user_repository import UserRepositoryImpl
from backend.src.domain.entities.ingredient import Ingredient
from backend.src.domain.entities.user import User

from backend.src.interface.database.models import Base

from backend.src.domain.services.ingredient_service import IngredientService
from backend.src.interface.database.database import SessionLocal, engine

dummy_ingredient = Ingredient(id = 1,
                              name = "test",
                              recipes = [])

@pytest.fixture
def ingredient_service():
    return IngredientService()

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
@pytest.mark.integration
class TestIngredientService():
    async def test_new_empty(self, ingredient_service: IngredientService, user, database):
        ingredients = await ingredient_service.get_all_ingredients(db)
        assert len(ingredients) == 27

    async def test_new_ingredient(self, ingredient_service: IngredientService, user, database):
        await ingredient_service.register_ingredient(dummy_ingredient, db)
        ingredients = await ingredient_service.get_all_ingredients(db)
        assert len(ingredients) == 1

    async def test_get_ingredient_when_empty(self, ingredient_service: IngredientService, user, database):
        ingredient = await ingredient_service.get_ingredient(1, db)
        assert ingredient is None

    async def test_get_ingredient(self, ingredient_service: IngredientService, user, database):
        await ingredient_service.register_ingredient(dummy_ingredient, db)
        ingredient = await ingredient_service.get_ingredient(1, db)
        assert ingredient is not None
