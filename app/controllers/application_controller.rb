class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_500

  add_flash_types :success, :error

  def render_403
    render file: 'public/403.html', status: 403, layout: false
  end

  # def render_404
  #   render file: 'public/404.html', status: 404, layout: false
  # end

  def render_500
    render file: 'public/500.html', status: 500, layout: false
  end

end
