class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :name, :email, uniqueness: true
  has_many :posts
  has_secure_password
end
