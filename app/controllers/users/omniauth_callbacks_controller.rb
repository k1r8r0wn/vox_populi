class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    omniauth = request.env['omniauth.auth']
    provider = Provider.where(name: omniauth['provider'], uid: omniauth['uid']).take

    if provider
      flash[:notice] = "Signed in successfully with #{provider.name.capitalize}."
      sign_in_and_redirect User.find(provider.user_id)
    elsif current_user
      current_user.providers.create(name: omniauth['provider'], uid: omniauth['uid'])
      flash[:notice] = 'Authentication successful.'
      sign_in_and_redirect current_user
    else
      user = (omniauth['info']['email'].present? && User.find_by(email: omniauth['info']['email']))
      user = User.new unless user
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = 'Signed in successfully with existing account.'
        sign_in_and_redirect(:user, user)
      else
        session['devise.user_attributes'] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end

  alias_method :facebook, :all

end
