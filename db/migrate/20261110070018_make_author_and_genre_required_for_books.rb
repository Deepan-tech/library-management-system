class MakeAuthorAndGenreRequiredForBooks < ActiveRecord::Migration[8.1]
  def change
    change_column_null :books, :author_id, false
    change_column_null :books, :genre_id, false
  end
end
