class PagesController < ApplicationController

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
