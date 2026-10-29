class Book < ApplicationRecord
  has_many :book_copies

    has_many :book_genres, dependent: :destroy
    has_many :genres, through: :book_genres

  validates :title, presence: true
  validates :isbn, presence: true
end
