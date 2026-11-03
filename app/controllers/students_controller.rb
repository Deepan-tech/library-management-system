class StudentsController < ApplicationController
  def index
    # @students = Student.all
    @search_by = params[:search_by]
    @query = params[:query].to_s.strip
    @students = Student.includes(:department)
    if @query.present?
      case @search_by
      when "student_name"
        @students = Student.where("students.username ILIKE ?","%#{@query}%")
      when "department"
        @students = @students.joins(:department).where("departments.department_name ILIKE?","%#{@query}%")
        @students = @students.order(:id)
      end
    end
  end

  def show
    @department = Department.find(params[:id])
     @students = @department.student
  end
end
