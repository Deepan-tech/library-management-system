class RegistrationsController < ApplicationController
  def new
    @student = Student.new
    @departments = Department.all
  end

  def create
    @student = Student.new(student_params)
    @departments = Department.all

    if @student.save
      redirect_to "/students/#{@student.id}",
                  notice: "Registration successful."
    else
      render :new, status: :unprocessable_entity
    end
  end
 
  private

  def student_params
    params.require(:student).permit(
      :username,
      :email,
      :mobile,
      :department_id,
      :password,
      :password_confirmation
    )
  end
end