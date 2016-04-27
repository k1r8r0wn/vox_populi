class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:statistics]

  layout 'home', only: [:home]

  def home; end

  def statistics
    @themes = []

    category = Category.eager_load(:themes)
    category.each do |category|
      @themes << [ category.name, category.themes.size ]
    end
  end

end
