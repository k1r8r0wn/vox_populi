module ThemesHelper
  def is_theme_owner?
    current_user == @theme.user || current_user.admin? || current_user.moderator?
  end
end
