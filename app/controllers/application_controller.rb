class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :render_403
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_500

  add_flash_types :success, :error

  helper_method :current_city

  def current_city
    @city ||= get_current_city
  end

  private

  def render_403
    render file: 'public/403.html', status: 403, layout: false
  end

  def render_404
    render file: 'public/404.html', status: 404, layout: false
  end

  def render_500
    render file: 'public/500.html', status: 500, layout: false
  end

  def get_current_city
    return City.find_by(id: session[:city_id]) if session[:city_id].present?

    city = City.find_by_ip(request.remote_ip)
    session[:city_id] = city.try(:id) if city

    city
  end
end
