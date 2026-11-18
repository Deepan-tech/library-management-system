module Api
  module V1
    class BaseController < ActionController::API
      attr_accessor :current_user, :current_role

      def authenticate_user!
        auth_header = request.headers["Authorization"]

        token = auth_header&.split(" ",2)&.last

        unless auth_header&.start_with?("Bearer ") && token.present?
          render json: {
            message: "Missing token"
          },status: :unauthorized
          return
        end

        payload = JwtService.decode(token)

         unless payload
          render json: {
            message: "Invalid or expired token"
          }, status: :unauthorized
          return
        end

        @current_role = payload["role"]
        
        @current_user = 
         case @current_role
         when "student"
           Student.find_by(id: payload["sub"])
         when "admin"
           ::Admin.find_by(id: payload["sub"])
         end

         unless @current_user
           render json: {
            message: "user not found"
           },status: :unauthorized 
           return
         end
      end
        def required_admin!
           unless @current_role == "admin"
            render json: {
              Message: "Access denied. Admin only."
            }, status: :forbidden  #403
             return    
           end
         end
    end
  end
end
