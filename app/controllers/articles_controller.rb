class ArticlesController < ApplicationController

  before_action :nikkei_info, only: [:index]
  # before_action :tag_result, only: [:search]

  def index
    # binding.pry
    # @articles = Article.includes(:tags).order('created_at DESC')
    @articles = Article.page(params[:page]).order("created_at DESC")
    # @tag_list = Tag.all
    # @tag = Tag.find(params[:tag_id])
    # @tag_articles = @tag.articles.all
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
    # @pages = Article.page(params[:page]).order("created_at DESC")
    @articles = Article.search(params[:keyword]).page(params[:page]).order("created_at DESC")

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

  # def tag_result
  #   return nil if params[:keyword] == ""
  #     tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
  #     render json:{ keyword: tag }
  # end

  def nikkei_info
    agent = Mechanize.new
    page = agent.get('https://stocks.finance.yahoo.co.jp/stocks/detail/?code=998407.O')
    @table = page.search("//table[@class='stocksTable']//tr/td")[1..-1]
  end
end
