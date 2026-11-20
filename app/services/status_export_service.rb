require "caxlsx"

class StatusExportService
  def initialize(statuses)
    @statuses = statuses
  end

  def call
    package = Axlsx::Package.new

    package.workbook.add_worksheet(name: "Borrowing Status") do |sheet|

      sheet.add_row [
        "Student Name",
        "Genre Name",
        "Book Name",
        "Copy Barcode",
        "Borrowed At",
        "Due At",
        "Return Status"
      ]

      @statuses.each do |status|
        sheet.add_row [
          status.student.username,
          status.book_copy.book.genre&.genre_name || "No genre assigned",
          status.book_copy.book.title,
          status.book_copy.barcode,
          status.barrowed_at,
          status.due_at,
          status.return_at.present? ? "Returned" : "Not Returned"
        ]
      end
    end
    
    package.to_stream.read
  end
end
