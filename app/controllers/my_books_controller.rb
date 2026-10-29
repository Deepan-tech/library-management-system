class MyBooksController < ApplicationController
  # before_action :require_student
  
  def index
    @statuses = Status.includes(book_copy: :book).where(student_id: session[:student_id]).where(return_at: nil)
  end
    private

  def require_student
    unless session[:student_id]
      redirect_to login_path, alert: "Please log in first."
    end
  end
end
