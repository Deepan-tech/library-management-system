require "test_helper"

class BookCopyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get book_copy_index_url
    assert_response :success
  end

  test "should get new" do
    get book_copy_new_url
    assert_response :success
  end

  test "should get _form" do
    get book_copy__form_url
    assert_response :success
  end
end
