class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @department = Department.find(params[:id])
     @students = @department.student
  end
end
