class ArticleTagRelation < ApplicationRecord
  belongs_to :article, optional: true
  belongs_to :tag, optional: true
end
