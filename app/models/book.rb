class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  has_many :book_copies, dependent: :destroy
  has_one_attached :cover_image
end