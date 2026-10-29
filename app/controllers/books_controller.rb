class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
 
  if @book.update(
    title: params[:book][:title],
    isbn: params[:book][:isbn],
    publication_date: params[:book][:publication_date]
  )
    redirect_to "/books"
  else
    render :edit, status: :unprocessable_entity
  end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to "/books"
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
    params.require(:book).permit(:title, :isbn ,:edition, :publication_date)
  end
end