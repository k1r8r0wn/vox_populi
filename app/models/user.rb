class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :categories

  validates :username, presence: true
  validates :username, :email, uniqueness: true
  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/ }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end

end
