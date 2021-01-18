class ArticleTagRelation < ApplicationRecord
  belongs_to :article
  belongs_to :tag

  validates :tag_id, presence: true
  validates :article_id, presence: true
end
