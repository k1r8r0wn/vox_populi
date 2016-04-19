class Theme < ActiveRecord::Base

  belongs_to :category
  belongs_to :user
  has_many   :comments, dependent: :destroy, as: :commentable

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true, length: { maximum: 3000 }

  before_save :capitalize_title

  def capitalize_title
    self.title = title.capitalize
  end

end
