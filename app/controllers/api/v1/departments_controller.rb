module Api
  module V1
    class DepartmentsController < BaseController

      before_action :authenticate_user!

      before_action :required_admin!, only: [:create, :update, :destroy]

      before_action :set_department,only: [:show, :update, :destroy]

      def index
        departments = Department.order(:department_name)
        render json: departments
      end

      def show
        render json: @department.as_json(
          include: {
            students: {
              only: [:id, :username, :email, :mobile]
            }
          }
        )
      end

      def create
        department = Department.new(department_params)
        if department.save
          render json: department, status: :created
        else
          render json: {
            errors: department.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @department.update(department_params)
          render json: @department, status: :ok
        else
          render json: {
            errors: @department.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @department.destroy!
        head :no_content

      rescue ActiveRecord::RecordNotDestroyed
        render json: {
          message: "Cannot delete department."
        }, status: :conflict
      end

      private

      def set_department
        @department = Department.find(params[:id])
      end

      def department_params
        params.require(:department).permit(:department_name)
      end

    end
  end
end