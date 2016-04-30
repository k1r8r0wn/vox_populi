module ThemesHelper
  def is_theme_owner?
    current_user == @theme.user || current_user.admin? || current_user.moderator?
  end

  def build_theme
    @theme.city_id = current_city.try(:id) if @theme.city_id.blank? && current_city
    @theme
  end
end
