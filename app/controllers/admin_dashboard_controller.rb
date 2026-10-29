class AdminDashboardController < ApplicationController
  def show
    @admin = Admin.find_by(id: session[:admin_id])
    @total_books = Book.count
    @total_students = Student.count
    @total_borrowing_records = Status.count
    @currently_borrowed = Status.where(return_at: nil).count
    
  end

  def showbook
  @genre = Genre.find(params[:id])
  @books = @genre.books
  end
end
