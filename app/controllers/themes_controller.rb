class ThemesController < ApplicationController

  before_action :authenticate_user!, only: [:new]

  def index
    @themes = Theme.where(category_id: params[:category_id])
  end

  def new; end

end
