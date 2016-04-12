class Theme < ActiveRecord::Base

  belongs_to :category

  validates :title, :content, presence: true
  validates :title, uniqueness: { case_sensitive: false }

  before_save :capitalize_title

  def capitalize_title
    self.title = title.capitalize
  end

end
