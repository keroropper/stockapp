class LikesController < ApplicationController

  before_action :article_params, only: [:create, :destroy]

  def create
    @like = Like.create(article_id: params[:article_id], user_id: current_user.id)
  end

  def destroy
    # Like.find_by(article_id: params[:id], user_id: current_user.id).destroy
    like = Like.find_by(user_id: current_user.id, article_id: params[:article_id])
    like.destroy
  end

  private

  def article_params
    @article = Article.find(params[:article_id])
  end
end
