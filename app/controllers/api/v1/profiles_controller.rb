
module Api
  module V1
    class ProfilesController < BaseController

      before_action :authenticate_user!

      def show
        render json: {
          message: "Authenticated successfully",
          user: {
            id: current_user.id,
            email: current_user.email,
            role: current_role
          }
        }
      end

    end
  end
end
