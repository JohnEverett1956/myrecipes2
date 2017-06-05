require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  def setup
    @recipe = Recipe.new(name: 'vegetable', description: 'great vegetable recipe')
  end
  
  test "recipe should be valid"  do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    @recipe.name = ""
    @recipe.save
    assert_not @recipe.valid?
  end
  
    test "description should be present" do
    @recipe.description = ""
    @recipe.save
    assert_not @recipe.valid?
  end
  
  test "description should not be less than 5 characters" do
    @recipe.description = "a" * 4
    @recipe.save
    assert_not @recipe.valid?    
  end
  
  test "description should not be more than 500 characters" do
    @recipe.description = "a" * 501
    @recipe.save
    assert_not @recipe.valid?

  end
  
end