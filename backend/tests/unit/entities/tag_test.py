from pydantic import ValidationError
import pytest

from backend.src.domain.entities.tag import Tag

@pytest.mark.asyncio
class TestTag():
    async def test_new_tag_missing_fields(self):
        with pytest.raises(ValidationError):
            Tag()

    async def test_new_tag(self):
        assert Tag(
            id = 1,
            description = "test",
            recipes = []
        )
