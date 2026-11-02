require "test_helper"

class BookCopiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_copies_index_url
    assert_response :success
  end

  test "should get new" do
    get book_copies_new_url
    assert_response :success
  end
end
