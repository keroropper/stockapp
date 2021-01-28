class Article < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  has_many :comments
  belongs_to :user
  has_many :likes


  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

    def save_tags(tag_list)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - tag_list
      new_tags = tag_list - current_tags
    
        # Destroy old taggings:
        old_tags.each do |old_name|
          self.tags.delete Tag.find_by(name:old_name)
        end
    
        # Create new taggings:
        new_tags.each do |new_name|
          tag_list = Tag.find_or_create_by(name:new_name)
          self.tags << tag_list
        end
    end

    # def self.search
    #   sort = params[:sort] || "created_at DESC"
    #   @keyword = params[:keyword]

    #   if @keyword.present?
    #     @articles = []
    #     #分割したキーワードごとに検索
    #     @keyword.split(/[[:blank:]]+/).each do |keyword|  #splitメソッドにより、入力された値を引数を区切り文字として、配列として返します。＋により連続した空白にも対応
    #       next if keyword == ""
    #       @articles += Article.where('title LIKE(?) OR content LIKE(?)', "%#{keyword}%", "%#{keyword}%")
    #     end
    #       @articles.uniq!
    #   else
    #     @articles.order(sort)
    #   end
    # end

    # def self.search(search)
    #   if search != ""
    #     split_keywords = search.split(/[[:blank:]]+/)
        
    #     @search_articles = []
    #     split_keywords.each do |keyword|
    #     next if keyword == "" #空白を検索しないようにする対策。こうしないと " "というように空白が検索され、つまり全部検索されてしまう
    #     @search_articles += Article.joins(:tags).where('content LIKE(?) OR title LIKE(?)' , "%#{search}%", "%#{search}%")
    #     end
    #     @search_articles.uniq!
    #   else
    #     Article.all
    #   end
    # end

end


