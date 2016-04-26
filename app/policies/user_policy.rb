class UserPolicy

  attr_reader :current_user, :user

  def initialize(current_user, user)
    raise Pundit::NotAuthorizedError unless current_user
    @current_user = current_user
    @user = user
  end

  def show?
    current_user
  end

  def all
    current_user && current_user.admin?
  end

  alias_method :edit?,    :all
  alias_method :update?,  :all
  alias_method :destroy?, :all

end
