class Theme < ActiveRecord::Base

  belongs_to :category
  belongs_to :user

  validates :title, :content, presence: true
  validates :title, uniqueness: { case_sensitive: false }

  before_save :capitalize_title

  def capitalize_title
    self.title = title.capitalize
  end

end
