module ThemesHelper

  def all_comments
    parent_comments = Comment.where(commentable_id: @theme)
    child_comments = Comment.where(commentable_id: parent_comments.map(&:id))
    parent_comments + child_comments
  end

end
