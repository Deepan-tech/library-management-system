require "test_helper"

class MyBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get my_books_index_url
    assert_response :success
  end
end
