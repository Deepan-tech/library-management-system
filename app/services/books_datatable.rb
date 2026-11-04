
class BooksDatatable

  def initialize(params)
    @params = params
  end

  def call
    books = Book.all

    # Total records before filtering
    total_records = books.count

    # Search
    search_value = @params.dig(:search, :value)

    if search_value.present?
      books = books.where(
        "books.title ILIKE :search OR books.isbn ILIKE :search",
        search: "%#{search_value}%"
      )
    end

    # Genre filtering
    genre_id = @params[:genre_id]

    if genre_id.present?
      books = books.joins(:genres)
                   .where(genres: { id: genre_id })
                   .distinct
    end

    # Count after filtering
    filtered_records = books.count

    # Sorting
    # Sorting

columns = {
  0 => "id",
  1 => "title",
  2 => "isbn",
  3 => "edition"
}

column_index = @params.dig(:order, 0, :column).to_i

column_name = columns[column_index] || "id"

direction =
  @params.dig(:order, 0, :dir) == "desc" ? "desc" : "asc"

books = books.order("#{column_name} #{direction}")

    # Pagination
    start = [@params[:start].to_i, 0].max

    length = @params[:length].to_i
    length = 10 if length <= 0
    length = [length, 100].min

    books = books.offset(start).limit(length)

    # JSON response
    {
      draw: @params[:draw].to_i,
      recordsTotal: total_records,
      recordsFiltered: filtered_records,
      data: books.map do |book|
        {
          id: book.id,
          title: book.title,
          isbn: book.isbn,
          edition: book.edition
        }
      end
    }
  end

end
