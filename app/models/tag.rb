class Tag < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :articles, through: :article_tag_relations

  validates :name, {uniqueness: true, presence: true}

  before_save :downcase_tag_name

  private

  def downcase_tag_name   #処理が始まる前に、保存される値を全て小文字に変換
    self.name.downcase!
  end
end
