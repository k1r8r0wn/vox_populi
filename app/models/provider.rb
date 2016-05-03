class Provider < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, :uid
end
