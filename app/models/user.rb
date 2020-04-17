class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create
  validates :name, :email, uniqueness: true
  has_many :posts
  mount_uploader :image_name, ImageUploader
  has_secure_password
end
