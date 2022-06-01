from typing import List, Any

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.ingredient import Ingredient 
from backend.src.domain.entities.tag import Tag 


class FilterService():

    def filter_by_ingredient(self, recipe_list: List[Recipe], ingredient_list: List[Ingredient]):
        def filter_func(recipe: Recipe) -> bool:
            return ingredient_list in recipe.ingredients
        return filter(filter_func, recipe_list)
    
    def filter_by_tag(self, recipe_list: List[Recipe], tag_list: List[Tag]):
        def filter_func(recipe: Recipe) -> bool:
            return tag_list in recipe.tags
        return filter(filter_func, recipe_list)
    