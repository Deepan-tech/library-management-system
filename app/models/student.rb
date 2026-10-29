class Student < ApplicationRecord
  belongs_to :department, optional: true

  has_many :statuses, dependent: :restrict_with_error

  has_secure_password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
end