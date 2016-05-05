class ThemesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category, except: [:new_separate, :create_separate]
  before_action :set_theme, only: [:show, :edit, :update, :destroy]

  def index
    @themes = Theme.where(category_id: params[:category_id])
    @themes = @themes.page(params[:page]).per(10)
  end

  def new
    @theme = @category.themes.new
    authorize @theme
  end

  def new_separate
    @theme = Theme.new
    @categories = Category.all
    authorize @theme
  end

  def show
    @root_comments = @theme.comments.root_comments
  end

  def edit; end

  def create
    authorize Theme
    @theme = @category.themes.new(theme_params)
    @theme.user_id = current_user.id

    if @theme.save
      redirect_to category_theme_path(@category, @theme), success: "Theme '#{@theme.title}' is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new
    end
  end

  def create_separate
    @theme = current_user.themes.new(theme_params)
    authorize @theme
    if @theme.save
      redirect_to category_theme_path(@theme.category, @theme), success: "Theme '#{@theme.title}' is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new_separate
    end
  end

  def update
    authorize @theme
    if @theme.update_attributes(theme_params)
      redirect_to category_theme_path(@category, @theme), success: "Theme '#{@theme.title}' is successfully updated!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :edit
    end
  end

  def destroy
    authorize @theme
    if @theme.destroy
      flash[:success] = 'Theme was successfully deleted.'
    else
      flash[:error] = 'Oops, theme could not be deleted.'
    end
    redirect_to category_themes_path
  end

  def vote_for
    current_user.vote_for(set_theme)
    voted?
  end

  def vote_against
    current_user.vote_against(set_theme)
    voted?
  end

  def revote
    current_user.unvote_for(set_theme)
    authorize @theme
    redirect_to :back, success: 'You successfully delete your vote!'
  end

  private

  def set_theme
    @theme = @category.themes.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def theme_params
    params.require(:theme).permit(:title, :content, :category_id, :city_id)
  end

  def voted?
    authorize @theme
    if @theme.voted_by?(current_user)
      redirect_to :back, success: 'You vote is accepted!'
    else
      redirect_to :back, error: 'Oops, something goes wrong!'
    end
  end

end
