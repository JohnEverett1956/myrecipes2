class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  validates_uniqueness_of :ingredient, :scope => :recipe
end