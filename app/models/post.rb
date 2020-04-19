class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
  belongs_to :user

  # searchメソッドの定義
  # searchにはparams[:keryword]が入っている
  def self.search(search)
    if search
      Post.where('content LIKE(?)', "%#{search}%")
    else
      Post.all
    end
  end
end
