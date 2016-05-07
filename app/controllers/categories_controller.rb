class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = current_user.categories.new
    authorize @category
  end

  def edit;
    authorize @category
  end

  def create
    authorize Category
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, success: t('.success', category: category_locale(@category))
    else
      flash.now[:error] = t('.error')
      render :new
    end
  end

  def update
    authorize @category
    if @category.update(category_params)
      redirect_to category_themes_path(@category), success: t('.success', category: category_locale(@category))
    else
      flash.now[:error] = t('.error')
      render :edit
    end
  end

  def destroy
    authorize @category
    if @category.destroy
      flash[:success] = t('.success')
    else
      flash[:error] = t('.error')
    end
    redirect_to categories_path
  end

  private

  def category_locale(category)
    if cookies[:locale] == 'ru'
      category.ru_name
    else
      category.name
    end
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :ru_name, :image)
  end

end
