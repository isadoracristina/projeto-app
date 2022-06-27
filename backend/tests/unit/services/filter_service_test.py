import pytest

from typing import List
from copy import deepcopy

from backend.src.domain.entities.ingredient import Ingredient
from backend.src.domain.entities.tag import Tag

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.services.filter_service import FilterService

@pytest.fixture
def recipe() -> Recipe:
    return Recipe(id=1,
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
def ingredients() -> List[Ingredient]:
    return [
        Ingredient(
            id=1,
            name="IngredienteTeste",
            recipes=[]
        ),
        Ingredient(
            id=2,
            name="IngredienteTeste2",
            recipes=[]
        ),
        Ingredient(
            id=3,
            name="IngredienteTeste3",
            recipes=[]
        ),
    ]

@pytest.fixture
def tags() -> List[Tag]:
    return [
        Tag(
            id=1,
            description="TagTeste1",
            recipes=[]
        ),
        Tag(
            id=2,
            description="TagTeste2",
            recipes=[]
        ),
        Tag(
            id=3,
            description="TagTeste3",
            recipes=[]
        ),
    ]

@pytest.fixture
def filter_service():
    return FilterService()

class TestFilterService():
    def test_filter_by_ingredient_simple(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        recipe.ingredients = [ingredients[0]]

        filtered = filter_service.filter_by_ingredient([recipe, recipe], [ingredients[0]])
        assert len(filtered) == 2

    def test_filter_by_ingredient_no_match(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        recipe.ingredients = [ingredients[0]]

        filtered = filter_service.filter_by_ingredient([recipe], [ingredients[1]])
        assert len(filtered) == 0

    def test_filter_by_ingredient_multiple_match(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        recipe2 = deepcopy(recipe)

        recipe.ingredients = [ingredients[1], ingredients[0]]
        recipe2.ingredients = [ingredients[0], ingredients[1]]

        filtered = filter_service.filter_by_ingredient([recipe, recipe2], [ingredients[0], ingredients[1]])
        assert len(filtered) == 2

    def test_filter_by_ingredient_multiple_parcial_match(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        recipe2 = deepcopy(recipe)

        recipe.ingredients = [ingredients[0], ingredients[1]]
        recipe2.ingredients = [ingredients[0], ingredients[2]]

        filtered = filter_service.filter_by_ingredient([recipe, recipe2], [ingredients[0], ingredients[1]])
        assert len(filtered) == 1

    def test_filter_by_ingredient_multiple_no_match(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        recipe2 = deepcopy(recipe)

        recipe.ingredients = [ingredients[0], ingredients[1]]
        recipe2.ingredients = [ingredients[1], ingredients[2]]

        filtered = filter_service.filter_by_ingredient([recipe, recipe2], [ingredients[0], ingredients[2]])
        assert len(filtered) == 0

    def test_filter_empty_recipe_empty_filter(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        filtered = filter_service.filter_by_ingredient([recipe], [])
        assert len(filtered) == 1

    def test_filter_empty_recipe_non_empty_filter(self, filter_service: FilterService, recipe: Recipe, ingredients: List[Ingredient]):
        filtered = filter_service.filter_by_ingredient([recipe], [ingredients[0]])
        assert len(filtered) == 0

    def test_filter_by_tag_simple(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe.tags = [tags[0]]

        filtered = filter_service.filter_by_tag([recipe, recipe], [tags[0]])
        assert len(filtered) == 2

    def test_filter_by_tag_no_match(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe.tags = [tags[0]]

        filtered = filter_service.filter_by_tag([recipe], [tags[1]])
        assert len(filtered) == 0

    def test_filter_by_tag_multiple_match(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe2 = deepcopy(recipe)

        recipe.tags = [tags[1], tags[0]]
        recipe2.tags = [tags[0], tags[1]]

        filtered = filter_service.filter_by_tag([recipe, recipe2], [tags[0], tags[1]])
        assert len(filtered) == 2

    def test_filter_by_tag_multiple_parcial_match(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe2 = deepcopy(recipe)

        recipe.tags = [tags[0], tags[1]]
        recipe2.tags = [tags[0], tags[2]]

        filtered = filter_service.filter_by_tag([recipe, recipe2], [tags[0], tags[1]])
        assert len(filtered) == 1

    def test_filter_by_tag_multiple_no_match(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe2 = deepcopy(recipe)

        recipe.tags = [tags[0], tags[1]]
        recipe2.tags = [tags[1], tags[2]]

        filtered = filter_service.filter_by_tag([recipe, recipe2], [tags[0], tags[2]])
        assert len(filtered) == 0

    def test_filter_empty_recipe_empty_filter(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        filtered = filter_service.filter_by_tag([recipe], [])
        assert len(filtered) == 1

    def test_filter_empty_recipe_non_empty_filter(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        filtered = filter_service.filter_by_tag([recipe], [tags[0]])
        assert len(filtered) == 0

    def test_fail(self, filter_service: FilterService, recipe: Recipe, tags: List[Tag]):
        recipe.ingredients = [tags[0], tags[1]]
        filtered = filter_service.filter_by_tag([recipe], [tags[2]])
        assert len(filtered) == 1
