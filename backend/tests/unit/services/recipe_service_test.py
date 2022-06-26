import pytest

from backend.src.adapters.repository.user_repository import UserRepositoryImpl
from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.user import User

from backend.src.interface.database.models import Base

from backend.src.domain.services.recipe_service import RecipeService
from backend.src.interface.database.database import SessionLocal, engine

dummy_recipe = Recipe(id=1,
                      id_user=1,
                      name= "ReceitaTeste",
                      img_addr="",
                      preparation_time_sec=122,
                      preparation_method="Teste",
                      rating=5.7,
                      observation="ObsvTeste",
                      last_made=None,
                      pantry_only=False,
                      ingredients=[],
                      tags=[])

@pytest.fixture
def recipe_service():
    return RecipeService()

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
class TestRecipeService():
    async def test_new_empty(self, recipe_service: RecipeService, user, database):
        recipes = await recipe_service.get_all_recipes(user, db)
        assert len(recipes) == 0

    async def test_new_recipe(self, recipe_service: RecipeService, user, database):
        await recipe_service.register_recipe(dummy_recipe, user, db)
        recipes = await recipe_service.get_all_recipes(user, db)
        assert len(recipes) == 1

    async def test_get_recipe_when_empty(self, recipe_service: RecipeService, user, database):
        recipe = await recipe_service.get_recipe(1, user, db)
        assert recipe is None

    async def test_get_recipe(self, recipe_service: RecipeService, user, database):
        await recipe_service.register_recipe(dummy_recipe, user, db)
        recipe = await recipe_service.get_recipe(1, user, db)
        assert recipe is not None

    async def test_update_recipe(self, recipe_service: RecipeService, user, database):
        await recipe_service.register_recipe(dummy_recipe, user, db)

        recipe = dummy_recipe
        recipe.name = "UpdatedRecipe"
        recipe.preparation_method = "New Preparation Method"

        updated_recipe = await recipe_service.update_recipe(recipe, 1, user, db)

        assert updated_recipe.name == "UpdatedRecipe"
        assert updated_recipe.preparation_method == "New Preparation Method"


