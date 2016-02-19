require 'test_helper'

class UserCanLogInAndSeeProfileDetailsTest < ActionDispatch::IntegrationTest

  test "user can login and see profile details" do
    user = create_nicole

    visit "/"
    click_button ""
  end

end
