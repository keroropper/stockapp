class ArticlesController < ApplicationController

  def index
  end

  def new
  end

  def create
  end

private
  
  params.require(:articles_tag).permit(:name, :title,
     :content, :image).merge(user_id: current_user.id,
       tag_id: params[:tag_id], article_id: params[:article_id])


end
