class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
    @genres = Genre.all
  end

  
  def update
  @book = Book.find(params[:id])

  if @book.update(book_params)
    redirect_to books_path, notice: "Book was successfully updated."
  else
    @genres = Genre.all
    render :edit, status: :unprocessable_entity
  end
end

  def new
    @book = Book.new
    @genres = Genre.all
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to "/books"
    else
       @genres = Genre.all
       render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_path, notice: "Book was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end
  
  def book_params
  params.require(:book).permit(
    :title,
    :isbn,
    :edition,
    :publication_date,
    genre_ids: []
  )
end

end