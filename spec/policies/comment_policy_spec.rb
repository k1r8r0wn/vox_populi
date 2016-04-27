require 'rails_helper'

describe CommentPolicy do

  let(:user) { create(:user) }

  subject { described_class }

  permissions :new?, :create? do
    it 'grants access for every user'  do
      expect(subject).to permit(create(:user))
      expect(subject).to permit(create(:admin))
      expect(subject).to permit(create(:moderator))
    end
  end

  permissions :edit?, :update?, :destroy? do
    it 'grants access only for admin, moderator' do
      expect(subject).to permit(create(:admin))
      expect(subject).to permit(create(:moderator))
    end

    it 'grant access if user is author of the comment' do
      expect(subject).to permit(user, create(:comment, user: user))
    end

    it 'denies access if user is not author of the comment' do
      expect(subject).not_to permit(User.new, create(:comment, user: user))
    end
  end

end
