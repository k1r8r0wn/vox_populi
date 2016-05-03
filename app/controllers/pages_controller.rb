class PagesController < ApplicationController

  before_action :authenticate_user!, only: [:statistics]

  layout 'home', only: [:home]

  def home; end

  def statistics
    @statistics = StatisticsFacade.new
  end

end
