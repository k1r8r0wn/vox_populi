class CommentPolicy

  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def all
    user
  end

  def edit_update_destroy
    user.admin? || user.moderator? || is_owner?
  end

  alias_method :new?,     :all
  alias_method :create?,  :all
  alias_method :edit?,    :edit_update_destroy
  alias_method :update?,  :edit_update_destroy
  alias_method :destroy?, :edit_update_destroy

  private

  def is_owner?
    user == comment.user
  end

end
