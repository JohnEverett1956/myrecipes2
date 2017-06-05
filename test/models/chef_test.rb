require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "jack", email: "jack@example.com")
  end
  
  test "chef must be valid" do
    assert @chef.valid?
  end
  
  test "chef name must be present" do
    @chef.chefname = " "
    @chef.save
    assert_not @chef.valid?
  end
  
  test "chef name should not exceed 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end  
  
  test "chef email must be present" do
    @chef.email = " "
    @chef.save
    assert_not @chef.valid?
  end
  
  test "email should not exceed 255 characters" do
    @chef.email = "a" * 256
    assert_not @chef.valid?
  end  
end