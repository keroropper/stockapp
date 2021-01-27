class CommentsController < ApplicationController

def create
  @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to "/articles/#{@comment.article.id}"
    else
      render root_path
    end
end

private
def comment_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id, article_id: params[:article_id])
end

end
