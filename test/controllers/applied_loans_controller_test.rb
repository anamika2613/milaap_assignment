require "test_helper"

class AppliedLoansControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get applied_loans_new_url
    assert_response :success
  end

  test "should get index" do
    get applied_loans_index_url
    assert_response :success
  end
end
