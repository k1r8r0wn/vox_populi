class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_category, except: [:index, :show]
  before_action :set_theme, except: [:index, :show]
  before_action :set_comment, only: [:edit, :update, :destroy]
  respond_to    :js, only: [:edit, :destroy]

  def new
    @comment = @theme.comments.new
    authorize @comment
  end

  def create
    authorize Comment
    @comment = @theme.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'Your comment is successfully added below!'
    else
      flash[:error] = "Your comment's content can't be blank!"
    end
    redirect_to :back
  end

  def edit; end

  def update
    authorize @comment
    if @comment.editable?
      if @comment.update_attributes(comment_params)
        flash[:success] = 'Your comment is successfully updated!'
      else
        flash[:error] = "Your comment's content can't be blank!"
      end
    else
      flash[:error] = 'Comment can be updated only in 5 minutes after creation.'
    end
    redirect_to :back
  end

  def destroy
    authorize @comment
    if @comment.destroy
      flash.now[:success] = 'Your comment is successfully deleted!'
    else
      flash.now[:error] = 'Comment was not deleted. Try again.'
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_theme
    @theme = @category.themes.find(params[:theme_id])
  end

  def set_comment
    @comment = @theme.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

end
