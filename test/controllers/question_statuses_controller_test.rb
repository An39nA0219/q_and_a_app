require "test_helper"

class QuestionStatusesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get question_statuses_create_url
    assert_response :success
  end

  test "should get destroy" do
    get question_statuses_destroy_url
    assert_response :success
  end
end
