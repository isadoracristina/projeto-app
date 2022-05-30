from sqlalchemy import Boolean, Column, ForeignKey, Integer, String, DateTime, Time, Text, Float
from sqlalchemy.orm import relationship

from .database import Base

class User(Base):
    __tablename__ = "Users"

    id_user = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, nullable=False)
    hash_psswd = Column(String, nullable=False)
    name_user = Column(String, nullable=False)
    date_registered = Column(DateTime, nullable=False)

    recipes = relationship("Recipe", back_populates="owner")

class Recipe(Base):
    __tablename__ = "Recipes"

    id_recipe = Column(Integer, primary_key=True, index=True)
    id_user = Column(Integer, ForeignKey("Users.id_user"), nullable=False)
    name_recipe = Column(String, nullable=False)
    img_addr = Column(String)
    prep_time = Column(Integer, nullable=False)
    prep_method = Column(Text)
    rating = Column(Float)
    observation = Column(Text)
    last_made = Column(DateTime)
    date_registered = Column(DateTime, nullable=False)
    pantry_only = Column(Boolean, nullable=False)

    owner = relationship("User", back_populates="recipes")
    ingredients = relationship("Recipe_Ingredient", back_populates="i_recipe")
    tags = relationship("Recipe_Tag", back_populates="t_recipe")

class Ingredient(Base):
    __tablename__ = "Ingredients"

    id_ingredient = Column(Integer, primary_key=True, index=True)
    name_ingredient = Column(String, nullable=False)

    i_recipes = relationship("Recipe_Ingredient", back_populates="i_ingredient")

class Tag(Base):
    __tablename__ = "Tags"

    id_tag = Column(Integer, primary_key=True, index=True)
    description_tag = Column(String, nullable=False)

    t_recipes = relationship("Recipe_Tag", back_populates="t_tags")

class Recipe_Ingredient(Base):
    __tablename__ = "Recipe_Ingredients"

    id_recipe = Column(Integer, ForeignKey("Recipes.id_recipe"), primary_key=True, index=True)
    id_ingredient = Column(Integer, ForeignKey("Ingredients.id_ingredient"), primary_key=True, index=True)
    amount = Column(Float, nullable=False)
    measurement = Column(String, nullable=False)
    
    i_recipe = relationship("Recipe", back_populates="ingredients")
    i_ingredient = relationship("Ingredient", back_populates="i_recipes")

class Recipe_Tag(Base):
    __tablename__ = "Recipe_Tags"

    id_recipe = Column(Integer, ForeignKey("Recipes.id_recipe"), primary_key=True, index=True)
    id_tag = Column(Integer, ForeignKey("Tags.id_tag"), primary_key=True, index=True)

    t_recipe = relationship("Recipe", back_populates="tags")
    t_tags = relationship("Tag", back_populates="t_recipes")