class ArticlesTag

  include ActiveModel::Model
  attr_accessor :title, :content, :name, :images, :user_id

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
    validates :name
  end

   delegate :presisdet?, to: :article #レコードに値があるかどうかでcreateかupdateかに分岐させる

   def initialize(attributes = nil, article: Article.new) #newメソッドでインスタンスを生成する際に初期値として設定する値
    @article = article
    attributes ||= default_attributes #attributesが存在すればその値を、nilならdefault_attributesをattributesに代入する
    super(attributes)  #initializeメソッドを、引数をattributesとして呼び出し
   end

   def save(tag_list)
     
    ActiveRecord::Base.transaction do
      @article.update(title: title, content: content)

      current_tags = @article.tags.pluck(:name) unless @article.tags.nil? #投稿した@articleに紐づくタグを配列で取得
      old_tags = current_tags - tag_list   #編集によって削除されたタグ
      new_tags = tag_list - current_tags   #新規タグ

      old_tags.each do |old_name|
        @article.tags.delete Tag.find_by(name: old_name)  #編集によって削除されたタグを削除
      end

      new_tags.each do |new_name|
        article_tag = Tag.find_or_create_by(name: new_name) #Tagモデルを通じてTagテーブルから、nameがnew_nameの物を探し、なければ保存する
        @article.tags << article_tag #上記のnew_nameを既存の@article.tagsに格納
        article_tag_relation = ArticleTagRelation.where(article_id: @article.id, tag_id: article_tag.id).first_or_initialize
        article_tag_relation.update(article_id: @article.id, tag_id: article_tag.id)
      end

    end
  end
  # def save
  #   article = Article.create(title: title, content: content, user_id: user_id, images: images)
  #   tag = Tag.where(name: name).first_or_initialize
  #   tag.save
  #   ArticleTagRelation.create(article_id: article.id, tag_id: tag.id)
  # end

private

  attr_reader :article, :tag #articleとtagを使ってデフォルト値を設定するために読み込み

  def default_attributes
    {
      title: article.title,
      content: article.content,
      name: article.tags.pluck(:name).join(',')
    }
  end

end
