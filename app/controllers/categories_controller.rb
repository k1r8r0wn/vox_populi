class CategoriesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_category, only: [:edit, :update, :destroy]

  # /categories GET
  def index
    @categories = Category.all
  end

  # /categories/new GET
  def new
    @category = current_user.categories.new
  end

  # /categories/:id/edit GET
  def edit; end

  # /categories POST
  def create
    @category = current_user.categories.create(category_params)
    if @category.errors.empty?
      redirect_to categories_path, success: "Category #{@category.name} is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new
    end
  end

  # /categories/:id PUT, PATCH
  def update
    @category.update_attributes(category_params)
    if @category.errors.empty?
      redirect_to category_themes_path(@category), success: "Category #{@category.name} is successfully updated!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :edit
    end
  end

  # /categories/:id DELETE
  def destroy
    @category.destroy
    flash[:success] = 'This category is successfully deleted!'
    redirect_to categories_path
  end

  private

  def find_category
    @category = Category.where(id: params[:id]).first
    render_404 unless @category
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
