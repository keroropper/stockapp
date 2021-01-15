class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = ArticlesTag.new
  end

  def create
    @article = ArticlesTag.new(article_tag_params)
    if @article.valid?
      @article.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def search
    return nil if params[:keyword] == ""
      tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
      render json:{ keyword: tag }
  end

private
  
  def article_tag_params
    params.require(:articles_tag).permit(:name, :title, :content, images: []).merge(user_id: current_user.id)
  end

end
