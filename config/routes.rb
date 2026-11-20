Rails.application.routes.draw do
  # puts "000000000000000000000000000000000000000000000"
  get "/status", to: "status#index"
  patch "/status/:id/return",to: "status#return_book",as: :return_status
  get "/status/export", to: "status#export", as: :export_status

  get "/signup", to: "registrations#new"
  post "/signup", to: "registrations#create"

  get "/students", to: "students#index"
  get "/students/:id", to: "students#show", as: :student

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/student/dashboard",to: "student_dashboard#show",as: :student_dashboard
  get "/admin/dashboard",to: "admin_dashboard#show",as: :admin_dashboard

  resources :books
  # resources :genre
  
  get "genre/index", to:"genre#index", as: :genre_index
  get "/genres/:id", to: "genre#show", as: :genre
  post "/genre/create", to: "genre#create"
  get "/genre/create", to: "genre#new", as: :genres

  get "/my-books", to: "my_books#index" 
  post "/books/:id/borrow", to: "borrowings#create", as: :borrow_book
  post "/book-copies/:id/borrow",to: "borrowings#create"
  
  get "/showbook", to: "admin_dashboard#showbook"
  get "/showbook/:id", to: "admin_dashboard#showbook", as: :showbook_genre
  
  patch "/books/edit/:id", to: "books#update"
  get "/books/edit/:id", to: "books#edit"
  get "/books/new", to: "books#new"

  get "/admin/department/index", to: "department#index"

  get "up" => "rails/health#show"
  get "/server-info", to: "server_info#show"

 namespace :api do
   namespace :v1 do
    post "login", to: "sessions#create"
    get "me", to: "profiles#show"
     get "admin/dashboard", to: "admin/dashboard#show" 
    
    resources :books, only: [:index, :show, :create, :update, :destroy]
    resources :authors, only: [:index, :show, :create, :update, :destroy]
    resources :genres, only: [:index, :show, :create, :update, :destroy]
    resources :departments, only: [:index, :show, :create, :update, :destroy]
    resources :book_copies, only: [:index, :show, :create, :update, :destroy]
  end
 end
end