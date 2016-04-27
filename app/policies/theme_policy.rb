class ThemePolicy

  attr_reader :user, :theme

  def initialize(user, theme)
    @user = user
    @theme = theme
  end

  def new_create
    user
  end

  def edit_update
    user.admin? || user.moderator? || is_owner?
  end

  def destroy?
    user.admin? || user.moderator?
  end

  alias_method :new?,              :new_create
  alias_method :new_separate?,     :new_create
  alias_method :create?,           :new_create
  alias_method :create_separate?,  :new_create
  alias_method :edit?,             :edit_update
  alias_method :update?,           :edit_update

  private

  def is_owner?
    user == theme.user
  end

end
