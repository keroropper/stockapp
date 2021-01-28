class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :comments
  has_many :likes

  validates :nickname, presence: true, length: { in: 2..6 } 

  # def liked_by?(article_id)
  #   likes.where(article_id: article_id).exists? #likesテーブルにarticle_idが存在するか確認している
  # end
end
