module ThemesHelper

  def is_theme_owner?
    current_user == @theme.user || current_user.admin? || current_user.moderator?
  end

  def build_theme
    @theme.city_id = current_city.try(:id) if @theme.city_id.blank? && current_city
    @theme
  end

  def form_name_locale
    if cookies[:locale] == 'ru'
      :ru_name
    else
      :name
    end
  end

  def category_name_locale
    if cookies[:locale] == 'ru'
      @category.ru_name
    else
      @category.name
    end
  end

end
