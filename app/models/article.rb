class Article < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :content, length: { maximum: 1000 }
  end

  # def save_tags(tag_list) #コントローラーから呼び出し
  #   tag_list.each do |tag|
  #     unless find_tag = Tag.find_by(name: tag.downcase) #DBを検索しても値がなく、find_tagに値が代入されない時に処理実行
  #       begin
  #         self.tags.create!(name: tag)#保存が成功しても失敗しても、オブジェクト＃を返してしまうため、！をつける事位よって例外処理を発生させている
  #       rescue 
  #         nil #上記の例外処理によって、nilが呼び出される。そうすると、値は保存されずに次の処理に進む
  #       end
  #     else
  #       ArticleTagRelation.create!(article_id: self.id, tag_id: find_tag.id)
  #     end
  #   end

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


end
