from pydantic import ValidationError
import pytest

from backend.src.domain.entities.recipe import Recipe

@pytest.mark.asyncio
class TestRecipe():
    async def test_new_recipe_missing_fields(self):
        with pytest.raises(ValidationError):
            Recipe()

    async def test_new_recipe(self):
        assert Recipe(
            id=1,
            id_user=1,
            name="TestName",
            img_addr="",
            preparation_time_sec=32,
            preparation_method="Test Prep Method",
            rating=0.34,
            observation="Test Observation",
            last_made=None,
            pantry_only=False,
            ingredients=[],
            tags=[]
        )
