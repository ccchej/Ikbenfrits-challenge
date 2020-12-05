require 'test_helper'

class PastriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pastries_index_url
    assert_response :success
  end

  test "should get show" do
    get pastries_show_url
    assert_response :success
  end

end
