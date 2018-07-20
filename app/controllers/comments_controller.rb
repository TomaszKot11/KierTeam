class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to problem_url(params[:comment][:problem_id]), notice: 'Comment added' }
        format.js
      else
        format.html { redirect_to problem_url(params[:comment][:problem_id], errors: @comment.errors.full_messages), alert: 'Something went wrong' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    problem_id = @comment.problem_id
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to problem_url(problem_id), notice: 'Comment deleted' }
        format.js
      else
        format.html { redirect_to problem_url(problem_id), alert: 'Could not delete the comment' }
      end
    end 
  end

  private

    def comment_params
      params.require(:comment).permit(:problem_id, :content,:title,:references, :user_id)
    end
    
end