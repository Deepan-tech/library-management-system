require "fileutils"

module Api
  module V1
    class StatusController < BaseController

      before_action :authenticate_user!
      before_action :required_admin!

      def export
        statuses = Status.includes(
          :student,
          book_copy: { book: :genre })

        excel_data = StatusExportService.new(statuses).call

        filename = "borrowing_status_#{Date.current}_#{Time.current.strftime('%H%M%S')}.xlsx"

        directory = Rails.root.join("storage", "exports")
        FileUtils.mkdir_p(directory)

        file_path = directory.join(filename)

        File.binwrite(file_path, excel_data)

        render json: {
          message: "Excel exported successfully",
          filename: filename,
          file_location: file_path.to_s
        }, status: :created
      end
    end
  end
end