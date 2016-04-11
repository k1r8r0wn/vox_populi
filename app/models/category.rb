class Category < ActiveRecord::Base

  belongs_to :user
  has_many :themes

  validates :name, presence: true

end
