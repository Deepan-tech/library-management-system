module Api
  module V1
    class GenresController < BaseController

      before_action :authenticate_user!

      before_action :required_admin!, only: [:create, :update, :destroy]

      before_action :set_genre, only: [:show, :update, :destroy]

      def index
        genres = Genre.order(:genre_name)
        render json: genres
      end

      def show
        render json: @genre.as_json(include: :books)
      end

      def create
        genre = Genre.new(genre_params)
        if genre.save
          render json: genre, status: :created
        else
          render json: {
            errors: genre.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        if @genre.update(genre_params)
          render json: @genre, status: :ok
        else
          render json: {
            errors: @genre.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def destroy
        if @genre.books.exists?
          render json: {
            message: "Cannot delete genre"
          }, status: :conflict
          return
        end

        @genre.destroy!
        head :no_content
      end

      private

      def set_genre
        @genre = Genre.find(params[:id])
      end

      def genre_params
        params.require(:genre).permit(:genre_name)
      end
    end
  end
end