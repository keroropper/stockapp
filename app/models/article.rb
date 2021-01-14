class Article < ApplicationRecord
  has_many :article_tag_relations
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user
end
