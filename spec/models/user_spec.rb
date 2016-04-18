require 'rails_helper'

describe User, type: :model do

  let(:user) { create(:user) }

  context 'relationships' do

    it { expect(user).to have_many(:categories).dependent(:destroy) }

    it { expect(user).to have_many(:themes).dependent(:destroy) }

    it { expect(user).to have_many(:comments) }

  end

  context 'validations' do

    it { expect(user).to validate_presence_of(:username) }

    it { expect(user).to validate_presence_of(:email) }

    it { expect(user).to validate_uniqueness_of(:username) }

    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }

    it 'requires the email to look like an email'do
      user.email = 'email'
      expect(user).to_not be_valid
    end

  end

  describe '#downcase_email' do

    before(:each) { user.email = 'EMAIL@MAIL.COM' }

    it 'makes the email attribute lower case' do
      expect { user.downcase_email }.to change{ user.email }.
          from('EMAIL@MAIL.COM').
          to('email@mail.com')
    end

    it 'downcases the email before saving' do
      expect(user.save).to be_truthy
      expect(user.email).to eq('email@mail.com')
    end

  end

end
