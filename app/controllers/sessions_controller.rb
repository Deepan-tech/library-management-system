class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:email].to_s.strip.downcase
    password = params[:password]

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
       puts "#{admin.username}"
      puts "##########################################################"
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

  def google_callback
    auth = request.env["omniauth.auth"]

    unless auth.present?
      redirect_to login_path, alert: "Google authentication failed."
      return
    end

    unless auth.dig("extra", "raw_info", "email_verified") == true
      redirect_to login_path, alert: "Google email is not verified."
      return
    end

    email = auth.dig("info", "email").to_s.downcase

  
    student = Student.where("LOWER(email) = ?", email).first

    unless student
      redirect_to login_path,
                  alert: "No registered student found with this Google email."
      return
    end

    reset_session
    session[:student_id] = student.id

    redirect_to student_dashboard_path,
                notice: "Google login successful."
     end

    def oauth_failure
      redirect_to login_path, alert: "Google authentication was unsuccessful."
    end

end