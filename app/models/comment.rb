class Comment < ActiveRecord::Base

  scope :root_comments, -> { where(root_comment_id: nil) }

  has_many   :subcomments, class_name: 'Comment', foreign_key: 'root_comment_id', dependent: :destroy
  belongs_to :theme
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }

  def root_comment?
    root_comment_id.nil?
  end

  def editable?
    created_at > (Time.now - 5.minutes)
  end

end
