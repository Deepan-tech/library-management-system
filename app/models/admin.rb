class Admin < ApplicationRecord
  has_secure_password

  validates :admin_name, presence: true
  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
end
