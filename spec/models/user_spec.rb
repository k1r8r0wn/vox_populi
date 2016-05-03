require 'rails_helper'

describe User, type: :model do

  let(:valid_attributes) {
    {
      username: 'user',
      email: 'john@doe.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.now
    }
  }

  context 'relationships' do
    let(:user) { create(:user) }

    it { expect(user).to have_many(:categories).dependent(:destroy) }

    it { expect(user).to have_many(:themes).dependent(:destroy) }

    it { expect(user).to have_many(:comments) }

    it { expect(user).to have_many(:providers) }
  end

  context 'validations' do
    let(:user) { create(:user) }

    it { expect(user).to validate_presence_of(:username) }

    it { expect(user).to validate_presence_of(:email) }

    it { expect(user).to validate_uniqueness_of(:username) }

    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }

    it 'requires the email to look like an email' do
      user.email = 'email'
      expect(user).to_not be_valid
    end
  end

  describe '#downcase_email' do
    it 'makes the email attribute lower case' do
      user = User.new(valid_attributes.merge(email: 'EMAIL@MAIL.COM'))
      expect { user.downcase_email }.to change{ user.email }.
        from('EMAIL@MAIL.COM').
        to('email@mail.com')
    end

    it 'downcases the email before saving' do
      user = User.new(valid_attributes.merge(email: 'EMAIL@MAIL.COM'))
      expect(user.save).to be_truthy
      expect(user.email).to eq('email@mail.com')
    end
  end

  describe '#set_default_role' do
    let(:user) { create(:user) }

    it "set's user role to 0 by default" do
      expect(user.role).to eq('user')
    end
  end

end
