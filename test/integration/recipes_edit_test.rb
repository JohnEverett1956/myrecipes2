require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
   @chef = Chef.create!(chefname: "john", email: "john@example.com",  password: "password", password_confirmation: "password")
   @recipe = Recipe.create(name: "saute", description: "do something", chef: @chef )
  end
  
  test "reject invalid recipe update" do
   sign_in_as(@chef,"password")
   get edit_recipe_path(@recipe)  
   assert_template "recipes/edit"
   patch recipe_path(@recipe), params: { recipe: {name: " ", description: "some description"}}
   assert_template "recipes/edit"   
   assert_select "h2.panel-title"
   assert_select "div.panel-body"      
    
  end
  
  test "successfully edit a recipe" do
   sign_in_as(@chef,"password")   
   updated_recipe_name = "Chicken saute"
   updated_recipe_description = "Add chicken, add vegetables, cook for 20 minutes, serve delicious meal"    
   get edit_recipe_path(@recipe) 
   assert_template "recipes/edit"   
   patch recipe_path(@recipe), params: { recipe: {name: updated_recipe_name, description: updated_recipe_description}}
   assert_redirected_to @recipe
   assert_not flash.empty?
   @recipe.reload
   assert_match updated_recipe_name, @recipe.name
   assert_match updated_recipe_description, @recipe.description
   #follow_redirect!
   #assert_match updated_recipe_name, response.body
   #assert_match updated_recipe_description, response.body   
  end
  
  
  
end
