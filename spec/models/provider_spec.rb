require 'rails_helper'

describe Provider, type: :model do
  let(:provider) { create(:provider) }

  context 'relationships' do
    it { should belong_to(:user) }
  end

  context 'validations' do
    it 'requires a name' do
      expect(provider).to validate_presence_of(:name)
    end

    it 'requires a uid' do
      expect(provider).to validate_presence_of(:uid)
    end
  end
end
