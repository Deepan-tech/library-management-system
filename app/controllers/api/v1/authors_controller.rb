class Api::V1::AuthorsController < Api::V1::BaseController
  before_action :authenticate_user!

  before_action :required_admin!, only: [:create, :update, :destroy]

  before_action :set_author, only: [:show, :update, :destroy]


  def index
      authors = Author.all
      render json: authors
  end 

  def show
    render json: @author.as_json(include: :books)
  end   

  def create
    author = Author.new(author_params)  

    if author.save
      render json: author, status: :created
    else
      render json: {
        errors: author.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

   def update
     if @author.update(author_params)
       render json: @author, status: :ok
     else
       render json: {
         errors: @author.errors.full_messages
         }, status: :unprocessable_entity
     end
   end
   
    def destroy
      if @author.books.exists?
        render json: {
          message: "Cannot delete foriegn key conflict"
        },status: :conflict
      end
      @author.destroy!

      head :no_content  
    end

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
     params.require(:author).permit(:author_name)
  end
end
