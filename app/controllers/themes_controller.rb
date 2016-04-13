class ThemesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :new_separate, :create_separate]
  before_action :find_category, only: [:index]
  before_action :find_category_current_user, only: [:new, :create]
  before_action :find_theme, only: [:show]

  # /categories/:category_id/themes GET
  def index
    @themes = Theme.where(category_id: params[:category_id])
  end

  # /themes/new GET
  def new
    @theme = @category.themes.new
  end

  # /themes/new GET
  def new_separate
    @theme = Theme.new
    @categories = Category.all
  end

  # /themes/create POST
  def create_separate
    @theme = current_user.themes.new(theme_params)
    if @theme.save
      redirect_to category_themes_path(@theme.category), success: "Theme #{@theme.title} is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new_separate
    end
  end

  # /categories/:category_id/themes/:id GET
  def show; end

  # /themes POST
  def create
    @theme = @category.themes.new(theme_params)
    if @theme.save
      redirect_to category_themes_path, success: "Theme #{@theme.title} is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new
    end
  end

  private

  def find_theme
    @theme = Theme.where(category_id: params[:category_id], id: params[:id]).first
    render_404 unless @theme
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def find_category_current_user
    @category = current_user.categories.find(params[:category_id])
  end

  def theme_params
    params.require(:theme).permit(:title, :content, :category_id)
  end

end
