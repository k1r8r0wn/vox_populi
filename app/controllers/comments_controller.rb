class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    @theme = Theme.find(params[:theme_id])
    @comment = @theme.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to category_theme_path(@theme.category, @theme), success: 'Your comment is successfully added below!'
    else
      redirect_to :back, error: @comment.errors[:content].first
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
