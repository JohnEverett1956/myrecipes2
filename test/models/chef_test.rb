require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: "jack", email: "jack@example.com",
    password: "password", password_confirmation: "password")
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
  
  
  test "should accept valid email addresse formats" do
    valid_emails = %w[user@example.com john@gmail.com test@yahoo.ca john.everett@shaw.ca john+everett@stl.ca.org]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid" 
    end
  end
  
  test "should reject invalid emil formats" do
    invalid_emails = %w[user@example user@example,com john.name@gmail. john@bar+foo.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end
  
  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  
  test "email should be lowercase before saving to the database" do
    mixed_email = "John@Example.Com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
  
  test "password should be present" do
    @chef.password = @chef.password_confirmation = " "
    assert_not @chef.valid?
  end
  
    test "password should be at least 5 characters" do
    @chef.password = @chef.password_confirmation = "x" * 4
    assert_not @chef.valid?
  end

end