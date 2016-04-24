class SubcommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_category
  before_action :set_theme
  before_action :set_comment
  before_action :comment_params, only: [:create]
  respond_to :js, only: [:new]

  def new; end

  def create
    @subcomment = @comment.subcomments.new(comment_params)
    @subcomment.user_id = current_user.id
    @subcomment.theme_id = @theme.id

    if @subcomment.save
      flash[:success] = 'Your comment is successfully added below!'
    else
      flash[:error] = "Your comment's content can't be blank!"
    end
    redirect_to :back
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_theme
    @theme = @category.themes.find(params[:theme_id])
  end

  def set_comment
    @comment = @theme.comments.find(params[:comment_id])
  end

  def comment_params
    params.require(:subcomment).permit(:content)
  end

end
