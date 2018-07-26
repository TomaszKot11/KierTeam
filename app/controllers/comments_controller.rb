class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params.merge(user_id: current_user.id))
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:problem_id, :content, :title, :references)
  end
end
