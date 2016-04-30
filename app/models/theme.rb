class Theme < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  belongs_to :city

  has_many   :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :content, presence: true, length: { maximum: 3000 }
  validates :city_id, presence: true

  before_save :capitalize_title

  def capitalize_title
    self.title = title.capitalize
  end

end
