ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module SignInHelper
  def sign_in_as(user, password = "password")
    post session_url, params: { email_address: user.email_address, password: password }
  end
end

module SystemSignInHelper
  def sign_in_as(user, password = "password")
    visit new_session_url

    fill_in "email_address", with: user.email_address
    fill_in "password", with: password
    click_button "Sign in"

    assert_selector "div", text: "Welcome back to Breakable Toys!"
  end
end
