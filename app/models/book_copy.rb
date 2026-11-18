class BookCopy < ApplicationRecord
   belongs_to :book

   has_many :statuses, dependent: :restrict_with_error

  validates :barcode, presence: true, uniqueness: true
  validates :copy_status, presence: true
end