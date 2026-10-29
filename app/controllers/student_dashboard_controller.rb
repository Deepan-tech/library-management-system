class StudentDashboardController < ApplicationController
  before_action :require_student

  def show
    @student = Student.find_by(id: session[:student_id])
  end

  def st_index
  @genre = Genre.find(params[:id])
  @books = @genre.books
  end

  private

  def require_student
    unless session[:student_id]
      redirect_to login_path
    end
  end
end