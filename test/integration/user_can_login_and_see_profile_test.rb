require 'test_helper'

class UserCanLogInTest < ActionDispatch::IntegrationTest

  test "user can login" do
    user = create_nicole
    visit "/"
    click_link "Login with Github"
    assert_equal dashboard_path, current_path
    assert page.has_content?("You Are Authorized")
  end

  test "user see profile details" do
    user = create_nicole
    visit "/"
    click_link "Login with Github"
    assert page.has_content?("#{user.nickname}")
    assert page.has_content?("#{user.email}")
  end

  test "user can logout" do
    visit "/"
    click_link "Login with Github"
    click_link "Logout"
    assert_equal root_path, current_path

  end

end
