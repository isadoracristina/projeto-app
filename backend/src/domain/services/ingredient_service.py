from backend.src.adapters.repository.ingredient_repository import IngredientRepositoryImpl
from backend.src.domain.entities.ingredient import Ingredient


class IngredientService():
    def __init__(self):
        self.ing_repo = IngredientRepositoryImpl()

    async def register_ingredient(self, ingredient: Ingredient, db) -> Ingredient:
        return await self.ing_repo.create(db, ingredient)

    async def get_ingredient(self, ingredient_id: int, db):
        return await self.ing_repo.get(db, ingredient_id)

    async def get_all_ingredients(self, db):
        return await self.ing_repo.get_all(db)

