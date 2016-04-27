class User < ActiveRecord::Base

  before_save :downcase_email
  after_initialize :set_default_role, if: :new_record?

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :moderator, :admin]

  has_many :categories, dependent: :destroy
  has_many :themes, dependent: :destroy
  has_many :comments

  validates :username, presence: true, uniqueness: true

  def downcase_email
    self.email = email.downcase
  end

  private

  def set_default_role
    self.role ||= :user
  end

end
