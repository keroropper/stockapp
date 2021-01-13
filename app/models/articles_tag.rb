class ArticlesTag

   include ActiveModel::Model
   attr_accessor :name, :title, :content, :image

   with_options presence: true do
    validates :name
     validates :title
     validates :content
   end








end