require "application_system_test_case"

class ApplicationsTest < ApplicationSystemTestCase
  include SystemSignInHelper

  setup do
    @application = applications(:one)
  end

  test "visiting the index" do
    sign_in_as users(:one)

    visit applications_url

    assert_selector "h1", text: "Applications"
  end

  test "should create application" do
    sign_in_as users(:one)

    visit applications_url
    click_on "New application"

    fill_in "Description", with: @application.description
    fill_in "Name", with: @application.name
    fill_in "Redirect url", with: @application.redirect_url
    fill_in "Url", with: @application.url
    click_on "Create Application"

    assert_text "Application was successfully created"
    click_on "Back"
  end

  test "should update Application" do
    sign_in_as users(:one)

    visit application_url(@application)
    click_on "Edit this application", match: :first

    fill_in "Description", with: @application.description
    fill_in "Name", with: @application.name
    fill_in "Redirect url", with: @application.redirect_url
    fill_in "Url", with: @application.url
    click_on "Update Application"

    assert_text "Application was successfully updated"
    click_on "Back"
  end

  test "should destroy Application" do
    sign_in_as users(:one)

    visit application_url(@application)
    click_on "Destroy this application", match: :first

    assert_text "Application was successfully destroyed"
  end
end
