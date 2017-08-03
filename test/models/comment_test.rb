require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @recipe_chef = Chef.create!(chefname: "john", email: "john@example.com", password: "password", password_confirmation: "password")
    @comment_chef = Chef.create!(chefname: "jack", email: "jack@example.com", password: "password", password_confirmation: "password")    
    @recipe = @recipe_chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
    @recipe.save
    @comment = Comment.create(description: "lovely recipe", chef_id: @comment_chef.id, recipe_id: @recipe.id )
  end
  
  test "comment must have a description" do
    @comment.description = " "
    assert_not @comment.valid? 
  end
  
  test "comment description must be a minimum of 4 characters" do
    @comment.description = "x" * 3
    assert_not @comment.valid?     
  end
  
  test "comment description must be a maximum of 140 characters" do
    @comment.description = "x" * 141
    assert_not @comment.valid?     
  end
  
  test "comment must have recipe reference" do
    @comment.recipe_id = nil
    assert_not @comment.valid?       
  end
  
  test "comment must have chef reference" do
    @comment.chef_id = nil
    assert_not @comment.valid?       
  end  
 
  test "comment must be deleted if chef is deleted" do
    @comment.save
    assert_difference "Comment.count", -1 do
       @comment_chef.destroy
    end    
  end  
  test "comment must be deleted if recipe is deleted" do
    @comment.save
    assert_difference "Comment.count", -1 do
       @recipe.destroy
    end    
  end    
  
end
