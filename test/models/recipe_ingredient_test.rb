require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "john", email: "john@example.com", password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
    @recipe.save
    @recipe.reload
    @ingredient1 = Ingredient.create!(name: "Chicken")
    @ingredient2 = Ingredient.create!(name: "Butter")
  end
  
  test "Record must have a recipe reference " do
    @recipe_ingredient = RecipeIngredient.create
    @recipe_ingredient.ingredient_id = @ingredient1
    assert_not  @recipe_ingredient.valid?
  end
  
  test "Record must have an ingredient reference" do
    @recipe_ingredient = RecipeIngredient.create
    @recipe_ingredient.recipe_id = @recipe
    assert_not  @recipe_ingredient.valid?
  end
  
  test "A Recipe can have more than one ingredient" do
    @recipe_ingredient1 = RecipeIngredient.create!(recipe_id:  @recipe.id, ingredient_id: @ingredient1.id) 
    @recipe_ingredient2 = RecipeIngredient.create!(recipe_id:  @recipe.id, ingredient_id: @ingredient2.id) 
    assert  @recipe_ingredient1.valid?
    assert  @recipe_ingredient2.valid?    
  end
  
  test "A Recipe cannot include same ingredient more than once" do
    @recipe_ingredient1 = RecipeIngredient.create!(recipe_id:  @recipe.id, ingredient_id: @ingredient1.id ) 
    @recipe_ingredient2 = RecipeIngredient.create(recipe_id:  @recipe.id, ingredient_id: @ingredient1.id)
    assert  @recipe_ingredient1.valid?
    assert_not  @recipe_ingredient2.valid?     
  end
end
