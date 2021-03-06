class ArticlesController < ApplicationController

require 'open-uri'

  before_action :nikkei_info, only: [:index, :tag_index, :search]
  # before_action :tag_result, only: [:search]

  def index
    @articles = Article.page(params[:page]).order("created_at DESC")
    @news = ArticlesHelper
    api = Rails.application.credentials.news_api[:api_key]
    uri = "https://newsapi.org/v2/everything?q=%E6%A0%AA%E4%BE%A1&sortBy=popularity&apiKey=#{api}"
    req = open(uri)
    article_serialized = open(uri).read
    @article_news = JSON.parse(article_serialized) 
  end

  def tag_index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @articles = @tag.articles.order("created_at DESC").page(params[:page]).order("created_at DESC")
    else
      @articles = Article.all.order("created_at DESC").page(params[:page]).order("created_at DESC")
    end
    @tag_list = Tag.all
    @news = ArticlesHelper
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
    # redirect_to root_path if params[:keyword] == ""
    # split_keyword = params[:keyword].split(/[[:blank:]]+/)
    # @articles = [] 
    # split_keyword.each do |keyword|
    #   next if keyword == "" 
    #   @articles += Article.joins(:tags).where('title LIKE(?) OR content LIKE(?) OR tags.name LIKE(?)', 
    #   "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
    # end 
    # @articles.uniq! #重複した投稿を削除する
    # @search_resoult = Article.page(params[:page]).order("created_at DESC")

    @articles = Article.joins(:tags)
    keywords = params[:keyword].split(/[[:blank:]]+/)
    # キーワードの数だけ Article.where(...) の部分を作ってます
    keywords = keywords.map do |keyword|
      @articles.where("title LIKE(:keyword) OR content LIKE(:keyword) OR tags.name LIKE(:keyword)", keyword: keyword)
    end

    # キーワードの最初のひとつは or ではなく、merge を用います
    @articles = @articles.merge(keywords[0])
    # 残りのキーワードを or で追加していきます
    keywords[1, keywords.length].each do |keyword|
      @articles = @articles.or(keyword)
    end
    @articles = @articles.page(params[:page]).order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
    @tags = @article.tags
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
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
