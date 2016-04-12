class Theme < ActiveRecord::Base

  belongs_to :category

  validates :title, :content, presence: true

end
