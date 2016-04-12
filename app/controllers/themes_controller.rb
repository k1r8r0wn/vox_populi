class ThemesController < ApplicationController

  before_action :authenticate_user!, only: [:new]
  before_action :find_category, only: [:index]

  def index
    @themes = Theme.where(category_id: params[:category_id])
  end

  def new; end

  private

  def find_category
    @category = Category.find(params[:category_id])
  end

end
