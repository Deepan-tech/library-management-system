class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].to_s.strip.downcase
    password = params[:password]

    # Check student credentials
    student = Student.find_by(email: email)

    if student&.authenticate(password)
      reset_session
      session[:student_id] = student.id

      redirect_to student_dashboard_path,
                  notice: "Student login successful."
      return
    end

    admin = Admin.find_by(email: email)

    if admin&.authenticate(password)
      reset_session
      session[:admin_id] = admin.id

      redirect_to admin_dashboard_path
      return
    end

    flash.now[:alert] = "Invalid email or password."
    render :new, status: :unprocessable_entity
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "Signed out successfully."
  end
end