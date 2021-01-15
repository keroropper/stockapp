class ArticlesTag

  include ActiveModel::Model
  attr_accessor :title, :content, :name, :images, :user_id

  with_options presence: true do
    validates :title
    validates :content
    validates :name
  end

  def save
    article = Article.create(title: title, content: content, user_id: user_id, images: images)
    tag = Tag.where(name: name).first_or_initialize
    tag.save

    ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  end

end
