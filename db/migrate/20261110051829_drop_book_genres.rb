class DropBookGenres < ActiveRecord::Migration[8.1]
  def change
    drop_table :book_genres
  end
end