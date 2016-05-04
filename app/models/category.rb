class Category < ActiveRecord::Base

  mount_uploader :image, CategoryImageUploader

  belongs_to :user
  has_many   :themes, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  before_save :capitalize_name

  def capitalize_name
    self.name = name.capitalize
  end

end
