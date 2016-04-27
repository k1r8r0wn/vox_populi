RailsAdmin.config do |config|

  # Devise
  config.authenticate_with do
    warden.authenticate! scope: :user
  end

  # Custom authorization
  config.authorize_with do
    redirect_to main_app.root_path, error: 'You are not authorized to perform this action.' unless current_user.admin?
  end

  # Method to call for current_user
  config.current_user_method(&:current_user)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    # With an audit adapter, you can add:
    history_index
    history_show
  end
end
