class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_commentable

  def new
    # @comment = Comment.new
    @comment = @commentable.comments.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # @theme = Theme.find(params[:theme_id])
    # @comment = @theme.comments.new(comment_params)
    @comment = @commentable.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, success: 'Your comment is successfully added below!' }
        format.js
      else
        format.html { redirect_to :back, error: @comment.errors[:content].first }
      end
    end
  end

  private

  def set_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Theme.find_by_id(params[:theme_id]) if params[:theme_id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
