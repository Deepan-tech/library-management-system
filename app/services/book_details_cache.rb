class BookDetailsCache
  def self.fetch(book_id)
    Rails.cache.fetch(
      "book_details/#{book_id}",
      expires_in: 10.minutes
    ) do
      book = Book.includes(:genre, :book_copies).find(book_id)

      {
        id: book.id,
        title: book.title,
        isbn: book.isbn,
        edition: book.edition,

        genre: {
          id: book.genre&.id,
          name: book.genre&.genre_name
        },

        book_copies: book.book_copies.map do |copy|
          {
            id: copy.id,
            barcode: copy.barcode,
            copy_status: copy.copy_status
          }
        end
      }
    end
  end
end