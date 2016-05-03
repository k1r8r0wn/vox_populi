require 'rails_helper'

describe ThemePolicy do

  let(:user) { create(:user) }

  subject { described_class }

  permissions :new?, :new_separate?, :create?,
  :create_separate?, :vote_for?, :vote_against?, :revote? do
    it 'grants access for every user'  do
      expect(subject).to permit(create(:user))
      expect(subject).to permit(create(:admin))
      expect(subject).to permit(create(:moderator))
    end

    it 'denies access if user is not signed in' do
      expect(subject).not_to permit(nil)
    end
  end

  permissions :edit?, :update? do
    it 'grants access only for admin, moderator' do
      expect(subject).to permit(create(:admin))
      expect(subject).to permit(create(:moderator))
    end

    it 'grants access if user is author of the theme' do
      expect(subject).to permit(user, create(:theme, user: user))
    end

    it 'denies access if user is not author of the theme' do
      expect(subject).not_to permit(User.new, create(:theme, user: user))
    end
  end

  permissions :destroy? do
    it 'grants access only for admin or moderator' do
      expect(subject).to permit(create(:admin))
      expect(subject).to permit(create(:moderator))
    end

    it 'denies access if user is author of the theme' do
      expect(subject).not_to permit(user, create(:theme, user: user))
    end

    it 'denies access if user is not author of the theme' do
      expect(subject).not_to permit(User.new, create(:theme, user: user))
    end
  end

end
