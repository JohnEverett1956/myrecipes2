require 'test_helper'

class IngredientsEditTest < ActionDispatch::IntegrationTest
  
  def setup
   @chef = Chef.create!(chefname: "john", email: "john@example.com",  password: "password", password_confirmation: "password", admin: true)
   @recipe = Recipe.create(name: "saute", description: "do something", chef: @chef )
   @ingredient = Ingredient.create(name: "Chicken")
  end
  
  test "reject invalid ingredient update" do
   sign_in_as(@chef,"password")
   get edit_ingredient_path(@ingredient)  
   assert_template "ingredients/edit"
   patch ingredient_path(@ingredient), params: { ingredient: {name: " "}}
   assert_template "ingredients/edit"   
  end
  
  test "successfully edited ingredient" do
   sign_in_as(@chef,"password")   
   updated_ingredient_name = "Duck"
   get edit_ingredient_path(@ingredient) 
   assert_template "ingredients/edit"   
   patch ingredient_path(@ingredient), params: { ingredient: {name: updated_ingredient_name}}
   assert_redirected_to @ingredient
   assert_not flash.empty?
   @ingredient.reload
   assert_match updated_ingredient_name, @ingredient.name 
  end
  
   test "reject edit by non-admin users" do
   @chef.admin = false
   @chef.save
   @chef.reload    
   sign_in_as(@chef,"password")   
   updated_ingredient_name = "Duck"
   patch ingredient_path(@ingredient), params: { ingredient: {name: updated_ingredient_name}}
   #assert_template "ingredients/index"  
   assert_not flash.empty?
  end 
end
