require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
   @chef = Chef.create!(chefname: "john", email: "john@example.com",  password: "password", password_confirmation: "password")
   @chef2 = Chef.create!(chefname: "john1", email: "john1@example.com",  password: "password", password_confirmation: "password")
   @admin_user = Chef.create!(chefname: "john2", email: "john2@example.com",  password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@chef,"password")    
    get edit_chef_path(@chef)
    assert_template "chefs/edit"    
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "john@example.com" }}
    assert_template "chefs/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  
  test "accept valid edit recipe_path" do
    sign_in_as(@chef,"password")    
    get edit_chef_path(@chef)
    assert_template "chefs/edit"    
    patch chef_path(@chef), params: {chef: {chefname: "john3", email: "john3@example.com" }}
    assert_redirected_to @chef 
    assert_not flash.empty?    
    @chef.reload
    assert_match "john3", @chef.chefname
    assert_match "john3@example.com", @chef.email
  end  
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user,"password")    
    get edit_chef_path(@chef)
    assert_template "chefs/edit"    
    patch chef_path(@chef), params: {chef: {chefname: "john3", email: "john3@example.com" }}
    assert_redirected_to @chef 
    assert_not flash.empty?    
    @chef.reload
    assert_match "john3", @chef.chefname
    assert_match "john3@example.com", @chef.email    
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2,"password")    
    patch chef_path(@chef), params: {chef: {chefname: "john3", email: "john3@exmpleample.com" }}
    assert_redirected_to chefs_path 
    assert_not flash.empty?    
    @chef.reload
    assert_match "john", @chef.chefname
    assert_match "john@example.com", @chef.email       
    
  end
  
end
