class StatusController < ApplicationController 
   def index
    @search_by = params[:search_by]
    @query = params[:query].to_s.strip

    @statuses = Status.includes(
      :student,
      book_copy: { book: :genres }
    )

    if @query.present?
      case @search_by

      when "student_name"
        student_ids = Student.where(
          "username ILIKE ?", "%#{@query}%"
        ).select(:id)

        @statuses = @statuses.where(student_id: student_ids)

      when "department"
        student_ids = Student.where(
          department_id: Department.where(
            "department_name ILIKE ?", "%#{@query}%"
          ).select(:id)
        ).select(:id)

        @statuses = @statuses.where(student_id: student_ids)

      when "status"
        case @query.downcase
        when "returned"
          @statuses = @statuses.where.not(return_at: nil)

        when "not returned"
          @statuses = @statuses.where(return_at: nil)

        else
          @statuses = @statuses.none
        end

      when "genre"
        book_ids = BookGenre.where(
          genre_id: Genre.where(
            "genre_name ILIKE ?", "%#{@query}%"
          ).select(:id)
        ).select(:book_id)

        copy_ids = BookCopy.where(
          book_id: book_ids
        ).select(:id)

        @statuses = @statuses.where(book_copy_id: copy_ids)

      when "book_name"
        book_ids = Book.where(
          "title ILIKE ?", "%#{@query}%"
        ).select(:id)

        copy_ids = BookCopy.where(
          book_id: book_ids
        ).select(:id)

        @statuses = @statuses.where(book_copy_id: copy_ids)

      end
    end

    @statuses = @statuses.order(created_at: :desc)
  end

  def return_book
    status = Status.find(params[:id])

    Status.transaction do
      status.lock!
      status.reload

      if status.return_at.present?
        redirect_to "/status"
        return
      end

      book_copy = status.book_copy
      book_copy.lock!

      status.update!(return_at: Time.current)
      book_copy.update!(copy_status: "available")
    end

    redirect_to "/status"

  end
end