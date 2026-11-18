module Api
  module V1
    module Admin
      class DashboardController < BaseController
        before_action :authenticate_user!
        before_action :required_admin!

         def show
          render json: {
            message: "Welcome Admin!",
            admin: {
              id: current_user.id,
              email: current_user.email
            }
          }
        end
      end
    end
  end
end