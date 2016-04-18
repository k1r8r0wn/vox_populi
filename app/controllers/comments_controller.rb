class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_category

  def create
    @theme = Theme.find(params[:theme_id])
    @theme.comments.create(comment_params)

    redirect_to category_theme_path(@category, @theme)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_category
    @category = Category.find(params[:category_id])
    render_404 unless @category
  end

end
