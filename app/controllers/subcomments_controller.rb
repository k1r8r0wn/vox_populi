class SubcommentsController < ApplicationController

  before_action :authenticate_user!

  def new
    respond_to do |format|
      format.js
    end
 end

  def create; end

end
