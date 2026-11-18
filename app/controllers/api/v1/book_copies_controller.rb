module Api
  module V1
    class BookCopiesController < BaseController

      before_action :authenticate_user!

      before_action :required_admin!, only: [:create, :update, :destroy]

      before_action :set_book_copy, only: [:show, :update, :destroy]

      def index
        book_copies = BookCopy.includes(:book)

        render json: book_copies.as_json(
          include: {
            book: {
              only: [:id, :title, :isbn]
            }
          }
        )
      end

      def show
        render json: @book_copy.as_json(
          include: {
            book: {
              only: [:id, :title, :isbn]
            }
          }
        )
      end

      def create
        book_copy = BookCopy.new(book_copy_params)

        book_copy.copy_status = "available"

        if book_copy.save
          render json: book_copy, status: :created
        else
          render json: {
            errors: book_copy.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @book_copy.update(book_copy_update_params)
          render json: @book_copy, status: :ok
        else
          render json: {
            errors: @book_copy.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        @book_copy.destroy!

        head :no_content

      rescue ActiveRecord::RecordNotDestroyed
        render json: {
          message: "Cannot delete this copy because borrowing records are associated with it."
        }, status: :conflict
      end

      private

      def set_book_copy
        @book_copy = BookCopy.find(params[:id])
      end

      def book_copy_params
        params.require(:book_copy).permit(
          :book_id,
          :barcode
        )
      end

      def book_copy_update_params
        params.require(:book_copy).permit(
          :barcode
        )
      end

    end
  end
end