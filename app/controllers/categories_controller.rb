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
      redirect_to categories_path, success: "Category '#{@category.name}' is successfully created!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :new
    end
  end

  def update
    authorize @category
    if @category.update(category_params)
      redirect_to category_themes_path(@category), success: "Category '#{@category.name}' is successfully updated!"
    else
      flash.now[:error] = 'Oops, you made some mistakes below.'
      render :edit
    end
  end

  def destroy
    authorize @category
    if @category.destroy
      flash[:success] = 'This category is successfully deleted!'
    else
      flash[:error] = 'Oops, category could not be deleted.'
    end
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :image)
  end

end
