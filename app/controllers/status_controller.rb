class StatusController < ApplicationController
  def index
    @statuses = Status.includes(:student, book_copy: :book)
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