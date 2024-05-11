require "test_helper"

class StracticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get stractic_pages_top_url
    assert_response :success
  end
end
