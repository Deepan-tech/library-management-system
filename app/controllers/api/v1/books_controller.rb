class Api::V1::BooksController < Api::V1::BaseController
      before_action :authenticate_user!

      before_action :required_admin!, only: [:create, :update, :destroy]

      before_action :set_book, only: [:show, :update, :destroy]

      def index
         books = Book.includes(:author, :genre)

         if params[:genre_id].present?
           books = books.where(genre_id: params[:genre_id])
         end

         if params[:author_id].present?
           books = books.where(author_id: params[:author_id])
         end

          render json: books.map { |book| book_response(book) }
      end
      def show
        render json: book_response(@book)
      end

      def create
        book = Book.new(book_params)

        if book.save
          render json: book, status: :created
        else
          render json: {
            errors: book.errors.full_messages
          },status: :unprocessable_entity
        end
      end

      def update
        if @book.update(book_params)
          render json: book_response(@book), status: :ok
        else
          render json: {
            errors: book.errors.full_messages
          },status: :unprocessable_entity
        end
      end

      def destroy
        @book.destroy

        head :no_content

        rescue ActiveRecord::RecordNotDestroyed
          render json: {
            errors: @book.errors.full_messages
          },status: unprocessable_entity
      end


      private 
      
    def book_response(book)
         book.as_json(include: [:author, :genre, :book_copies])
      .merge(
        cover_image_url: book.cover_image.attached? ?
          rails_blob_url(book.cover_image, host: request.base_url) : nil
      )
    end

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :isbn, :edition, :publication_date, :author_id, :genre_id)
      end

end
