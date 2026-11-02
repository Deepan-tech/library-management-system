class DepartmentController < ApplicationController
  def index
    @department = Department.all
    # @student = @department.student
  end
end
