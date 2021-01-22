class ArticlesController < ApplicationController

  def index
    # @articles = Article.includes(:tags).order('created_at DESC')
    @articles = Article.page(params[:page]).order("created_at DESC")
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_tag_params)
    if @article.save
      tag_list = tag_params[:name].split(/[[:blank:]]+/).select(&:present?)#空白で区切る
      @article.save_tags(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def search
    return nil if params[:keyword] == ""
      tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
      render json:{ keyword: tag }
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tags
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list = @article.tags.pluck(:name)
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_tag_params)  
       tag_list = tag_params[:name].split(/[[:blank:]]+/).select(&:present?)#空白で区切る  
       @article.save_tags(tag_list)
      redirect_to root_path
    else
      render :edit
    end
  end





private
  
  def article_tag_params
    params.require(:article).permit(:title, :content).merge(user_id: current_user.id,
       images: params[:article][:images])
  end

  def tag_params
    params.require(:article).permit(:name)
  end
end
