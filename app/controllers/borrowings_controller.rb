class BorrowingsController < ApplicationController
  before_action :require_student

  def create
    @book_copy = BookCopy.find(params[:id]) 
    borrowed = false

    BookCopy.transaction do
      @book_copy.lock!

      if @book_copy.copy_status == "available" &&
         !Status.exists?(book_copy_id: @book_copy.id, return_at: nil)

        Status.create!(
          student_id: session[:student_id],
          book_copy_id: @book_copy.id,
          barrowed_at: Time.current,
          due_at: 14.days.from_now,
          return_at: nil
        )

        @book_copy.update!(copy_status: "borrowed")
        borrowed = true
      end
    end 

    if borrowed
      redirect_to "/my-books"
    else
      redirect_to "/books"
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to "/books", alert: "Book copy not found."
  rescue ActiveRecord::RecordInvalid
    redirect_to "/books", alert: "Unable to borrow this book."
  end

  def require_student
    unless session[:student_id]
      redirect_to login_path, alert: "Please log in as a student."
    end
  end
end