require "test_helper"

class StudentDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get student_dashboard_show_url
    assert_response :success
  end
end
