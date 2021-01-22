class Article < ApplicationRecord
  has_many :article_tag_relations, dependent: :destroy
  has_many :tags, through: :article_tag_relations
  has_many_attached :images
  belongs_to :user


  def save_tags(tag_list) #コントローラーから呼び出し
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(name: tag.downcase) #DBを検索しても値がなく、find_tagに値が代入されない時に処理実行
        begin
          self.tags.create!(name: tag)#保存が成功しても失敗しても、オブジェクト＃を返してしまうため、！をつける事位よって例外処理を発生させている
        rescue 
          nil #上記の例外処理によって、nilが呼び出される。そうすると、値は保存されずに次の処理に進む
        end
      else
        ArticleTagRelation.create!(article_id: self.id, tag_id: find_tag.id)
      end
    end

  end






end
