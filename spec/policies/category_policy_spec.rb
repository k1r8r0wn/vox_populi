require 'rails_helper'

describe CategoryPolicy do
  subject { described_class }

  permissions :new?, :edit?, :create?, :update?, :destroy? do
    it 'grants access if user is admin'  do
      expect(subject).to permit(create(:admin))
    end

    it 'denies access if user is not admin' do
      expect(subject).not_to permit(create(:user))
      expect(subject).not_to permit(create(:moderator))
    end
  end

end
