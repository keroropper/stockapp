class Tag < ApplicationRecord
  has_many :articles_tag_rerations
  has_many :articles, through: :articles_tag_rerations
end
