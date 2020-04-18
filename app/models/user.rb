class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..12 }, on: :create
  validates :password, length: { in: 6..12 }, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_many :posts
  mount_uploader :image_name, ImageUploader
  has_secure_password
end
