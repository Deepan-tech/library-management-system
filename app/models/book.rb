class Book < ApplicationRecord
  belongs_to :author, optional: true
  belongs_to :genre, optional: true

  has_many :book_copies, dependent: :destroy
end