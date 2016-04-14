class ThemesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_category, except: [:new_separate, :create_separate]
  before_action :find_theme, only: [:show, :edit, :update, :destroy]

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

  # /categories/:category_id/themes/:id GET
  def show; end

  # /categories/:category_id/themes/:id/edit GET
  def edit; end

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

  # /categories/:category_id/themes/:id PUT, PATCH
  def update
    if @theme.update_attributes(theme_params)
      redirect_to category_theme_path(@category, @theme), success: "Theme #{@theme.title} is successfully updated!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :edit
    end
  end

  # /categories/:category_id/themes/:id DELETE
  def destroy
    if @theme.destroy
      flash[:success] = 'Theme was successfully deleted.'
    else
      flash[:error] = 'Oops, theme could not be deleted.'
    end
    redirect_to category_themes_path
  end

  private

  def find_theme
    @theme = @category.themes.find(params[:id])
    render_404 unless @theme
  end

  def find_category
    @category = Category.find(params[:category_id])
    render_404 unless @category
  end

  def theme_params
    params.require(:theme).permit(:title, :content, :category_id)
  end

end
