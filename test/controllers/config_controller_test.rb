require 'test_helper'

class ConfigControllerTest < ActionDispatch::IntegrationTest
  test "should get desc:string" do
    get config_desc:string_url
    assert_response :success
  end

end
