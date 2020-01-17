require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    
  end


  test "unsuccessful edit" do
    get edit_user_path @user
    assert_template 'users/edit'
    patch user_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end
end
