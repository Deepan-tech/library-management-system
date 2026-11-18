class Department < ApplicationRecord
  has_many :students, dependent: :restrict_with_error
  
  validates :department_name, presence: true
end
