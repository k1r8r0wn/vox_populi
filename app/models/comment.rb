class Comment < ActiveRecord::Base

  scope :root_comments, -> { where(root_comment_id: nil) }

  has_many :comments, dependent: :destroy
  has_many :subcomments, class_name: 'Comment', foreign_key: 'root_comment_id'
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }


  def root_comment?
    root_comment_id.nil?
  end

end
