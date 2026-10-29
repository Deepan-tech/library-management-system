class Status < ApplicationRecord
   belongs_to :student
   belongs_to :book_copy

  validates :barrowed_at, presence: true
  validates :due_at, presence: true
end
