class Comment < ActiveRecord::Base

  has_many   :comments, dependent: :destroy, as: :commentable
  belongs_to :commentable, dependent: :destroy, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: { maximum: 500 }

end
