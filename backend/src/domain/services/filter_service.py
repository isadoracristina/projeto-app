from typing import List, Any

from backend.src.domain.entities.recipe import Recipe
from backend.src.domain.entities.ingredient import Ingredient 
from backend.src.domain.entities.tag import Tag 


class FilterService():

    def filter_by_ingredient(self, recipe_list: List[Recipe], ingredient_list: List[Ingredient]):
        def filter_func(recipe: Recipe) -> bool:
            ing_ids = [ing.id for ing in ingredient_list]
            recipe_ing_ids = [ing.id_ingredient for ing in recipe.ingredients]
            return all([(id in recipe_ing_ids) for id in ing_ids])
        return list(filter(filter_func, recipe_list))

    def filter_by_tag(self, recipe_list: List[Recipe], tag_list: List[Tag]):
        def filter_func(recipe: Recipe) -> bool:
            return tag_list in recipe.tags
        return filter(filter_func, recipe_list)
