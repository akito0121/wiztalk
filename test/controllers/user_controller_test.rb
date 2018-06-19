require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get regist" do
    get user_regist_url
    assert_response :success
  end

end
