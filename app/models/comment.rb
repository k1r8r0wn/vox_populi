class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :theme

  validates :content, presence: true

end
