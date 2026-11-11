class Book < ApplicationRecord
  belongs_to :author
  belongs_to :genre

  has_many :book_copies, dependent: :destroy
end