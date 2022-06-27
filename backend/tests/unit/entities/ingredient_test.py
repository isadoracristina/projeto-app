from pydantic import ValidationError
import pytest

from backend.src.domain.entities.ingredient import Ingredient

@pytest.mark.asyncio
class TestIngrendient():
    async def test_new_ingredient_missing_fields(self):
        with pytest.raises(ValidationError):
            Ingredient()

    async def test_new_ingredient(self):
        assert Ingredient(
            id = 1,
            name = "test",
            recipes = []
        )
