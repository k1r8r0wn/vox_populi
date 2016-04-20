class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_category
  before_action :set_theme

  def new
    @comment = @theme.comments.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = @theme.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to :back, success: 'Your comment is successfully added below!'
    else
      redirect_to :back, error: @comment.errors[:content].first
    end
  end

  private

  def set_category
    category_id =  Theme.find(params[:theme_id]).category_id
    @category = Category.find(category_id)
  end

  def set_theme
    @theme = @category.themes.find(params[:theme_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
