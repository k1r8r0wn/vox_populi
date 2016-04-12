class Category < ActiveRecord::Base

  belongs_to :user
  has_many :themes, dependent: :destroy

  validates :name, presence: true

end
