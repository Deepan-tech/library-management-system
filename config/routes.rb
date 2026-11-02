Rails.application.routes.draw do
  get "/status", to: "status#index"
  patch "/status/:id/return",to: "status#return_book",as: :return_status

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
end