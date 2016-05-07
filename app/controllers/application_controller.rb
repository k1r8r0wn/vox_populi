class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from Pundit::NotAuthorizedError, with: :render_403
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActiveSupport::MessageVerifier::InvalidSignature, with: :render_500

  add_flash_types :success, :error

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

  def set_locale
    if cookies[:locale] && I18n.available_locales.include?(cookies[:locale].to_sym)
      lang = cookies[:locale].to_sym
    else
      lang = I18n.default_locale
      cookies.permanent[:locale] = lang
    end
    I18n.locale = lang
  end

end
