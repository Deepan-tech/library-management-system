class GenreController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @books = @genre.books
  end
   
  def new 
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.create(genre_param)
    if @genre.save
      redirect_to genre_index_path
    else
      puts "Genre creation fails"
    end
  
  end
  def genre_param
    params.require(:genre).permit(:genre_name)
  end
end
