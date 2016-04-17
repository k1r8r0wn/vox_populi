class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories, dependent: :destroy
  has_many :themes, dependent: :destroy

  validates :username, presence: true
  validates :username, uniqueness: true

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

end
