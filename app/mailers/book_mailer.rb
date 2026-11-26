class BookMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.book_mailer.book_available.subject
  #
  def book_available
    @student = params[:student]
    @book = params[:book]

    mail(to: "to@example.org", subject: "your request book is available") 
  end
end