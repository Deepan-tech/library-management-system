
module Api
  module V1
    class SessionsController < BaseController

      def create
        email = params[:email].to_s.strip.downcase
        password = params[:password]

        user = Student.find_by(email: email)
        role = "student"

        unless user&.authenticate(password)
          user = ::Admin.find_by(email: email)
          role = "admin"
        end
        puts "###################################"
        puts "#{user.email}"
        puts "#{role}"
        puts "###################################"
        unless user&.authenticate(password)
          render json: {
            message: "Invalid email or password"
          }, status: :unauthorized
          return
        end

  
        token = JwtService.encode(
          sub: user.id,
          role: role
        )

        render json: {
          message: "Login successful",
          token: token,
          user: {
            id: user.id,
            email: user.email,
            role: role
          }
        }, status: :ok
      end
    end
  end
end
