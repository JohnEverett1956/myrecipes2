require 'test_helper'

class IngredientsTest < ActionDispatch::IntegrationTest
  
  def setup
    @ingredient = Ingredient.create!(name: "First")
    @ingredient2 = Ingredient.create!(name: "Second")
    @chef = Chef.create!(chefname: "john", email: "john@example.com",  password: "password", password_confirmation: "password", admin: true )
  end  
  
  test "should get ingredients index" do
    get ingredients_url
    assert_response :success 
  end
  
  test "should get ingredients listing" do
    get ingredients_path
    assert_template "ingredients/index"
    assert_select "a[href=?]", ingredient_path(@ingredient), text: @ingredient.name.capitalize
    #test fails on second ingredient not found in listing - don't know why yet.
    assert_select "a[href=?]", ingredient_path(@ingredient2), text: @ingredient2.name.capitalize
  end  
  
  test "should get ingredients show" do
    get ingredient_path(@ingredient)
    assert_template "ingredients/show"
    assert_match @ingredient.name, response.body
  end  
  
  test "create new valid ingredient" do
    sign_in_as(@chef,"password")
    get new_ingredient_path 
    assert_template "ingredients/new"
    name_of_ingredient = "Chicken"  
    assert_difference "Ingredient.count", 1 do
      post ingredients_path, params: {ingredient: {name: name_of_ingredient}} 
    end
    follow_redirect!
    assert_match name_of_ingredient, response.body    
  end  
  
  test "reject invalid ingredient submission" do
    sign_in_as(@chef,"password")    
    get new_ingredient_path 
    assert_template "ingredients/new"    
    name_of_ingredient = ""  
    assert_no_difference "Ingredient.count" do
      post ingredients_path, params: {ingredient: {name: name_of_ingredient}} 
    end
    assert_template "ingredients/new"    
  end
end
