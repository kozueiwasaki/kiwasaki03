class User < ApplicationRecord
  validates :name, :email, :password, presence: true
  validates :name, :email, uniqueness: true
  has_many :posts
  has_secure_password
end
