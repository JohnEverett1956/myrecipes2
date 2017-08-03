require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  def setup
    @ingredient = Ingredient.new(name: "carrots")
    @ingredient2 = Ingredient.new(name: "carrots")
  end
  
  test "ingredient must be valid" do
    assert @ingredient.valid?
    assert @ingredient2.valid?  
  end
  
  test "ingredient must have a name" do
    @ingredient.name  = " "
    @ingredient.save
    assert_not @ingredient.valid?    
  end
  
  test "ingredient name must be unique" do
    @ingredient.save
    @ingredient2.save    
    assert_not @ingredient2.valid? 
   end
   
  test "ingredient name must a minimum of 3 charactes" do
    @ingredient.name  = "*" * 2
    @ingredient.save
    assert_not @ingredient.valid?    
  end    
 
  test "ingredient name must be a maximum of 25 charactes" do
    @ingredient.name  = "*" * 26
    @ingredient.save
    assert_not @ingredient.valid?    
  end     
  
end
