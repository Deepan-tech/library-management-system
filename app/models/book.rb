class Book < ApplicationRecord
    
    after_commit :expire_book_cache,
     on: [:create, :update, :destroy]

    private

    def expire_book_cache
     Rails.cache.delete("book_details/#{id}")
    end

    has_many :book_copies, dependent: :destroy

    has_many :book_genres, dependent: :destroy
    has_many :genres, through: :book_genres

    validates :title, presence: true
    validates :isbn, presence: true
end
