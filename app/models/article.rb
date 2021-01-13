class Article < ApplicationRecord
  has_many :articles_tag_rerations
  has_many :tags, through: :articles_tag_rerations
  has_one_attached :image
end
