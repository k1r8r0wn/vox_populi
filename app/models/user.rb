class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  before_save :downcase_email
  after_initialize :set_default_role, if: :new_record?

  devise :database_authenticatable,
  :registerable,
  :recoverable,
  :rememberable,
  :trackable,
  :validatable,
  :confirmable,
  :omniauthable

  enum role: [:user, :moderator, :admin]

  has_many :categories, dependent: :destroy
  has_many :themes, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_many :comments

  validates :username, presence: true, uniqueness: true

  acts_as_voter

  def apply_omniauth(omniauth)
    self.username = omniauth['info']['name'] || omniauth['info']['first_name'] || omniauth['info']['nickname'] if username.blank?
    self.email =    omniauth['info']['email'] if email.blank?

    providers.build(:name => omniauth['provider'],
                    :uid => omniauth['uid']
    )
  end

  def password_required?
    (providers.empty? || !password.blank?) && super
  end

  def email_required?
    email && providers.empty?
  end

  def downcase_email
    self.email = email.downcase
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  private

  def set_default_role
    self.role ||= :user
  end

end
