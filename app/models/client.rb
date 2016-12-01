class Client < ApplicationRecord
  has_many  :accounts
  has_many :transactions, through: :accounts
  has_secure_password
  validates :name, presence: true
  validates :email, uniqueness: true
end
