require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_params = {
      username: "Clarence Worley",
      email_address: "clarence.worley@email.com",
      password: "pa$$w0rd",
      password_confirmation: "pa$$w0rd"
    }
  end

  test "should get sign-up page" do
    get sign_up_url

    assert_response :success
  end

  test "should create user with valid data" do
    post sign_up_url, params: { user: @user_params }

    assert_response :redirect
    assert_equal "Welcome to Breakable Toys!", flash[:notice]
  end
  
  test "should not create user with duplicated email" do
    @user_params[:email_address] = users(:one).email_address

    post sign_up_url, params: { user: @user_params }
  
    assert_response :unprocessable_entity
  end
  
  test "should not create user if passwords don't match" do
    @user_params[:password_confirmation] = "not_the_same"

    post sign_up_url, params: { user: @user_params }
  
    assert_response :unprocessable_entity
  end
end
