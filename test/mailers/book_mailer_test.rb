require "test_helper"

class BookMailerTest < ActionMailer::TestCase
  test "book_available" do
    mail = BookMailer.book_available
    assert_equal "Book available", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
