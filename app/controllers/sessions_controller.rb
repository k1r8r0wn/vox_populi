class SessionsController < ApplicationController
  def change_locale
    lang = params[:locale].to_s.strip.to_sym
    lang = I18n.default_locale unless I18n.available_locales.include?(lang)
    cookies.permanent[:locale] = lang
    redirect_to request.referer || root_url
  end
end
