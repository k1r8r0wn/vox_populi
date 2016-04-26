class CategoryPolicy

  attr_reader :user, :category

  def initialize(user, category)
    @user = user
    @category = category
  end

  def all
    user.admin?
  end

  alias_method :new?,     :all
  alias_method :edit?,    :all
  alias_method :create?,  :all
  alias_method :update?,  :all
  alias_method :destroy?, :all

end
