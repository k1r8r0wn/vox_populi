require 'rails_helper'

describe Theme, type: :model do

  let(:theme) { create(:theme) }

  context 'relationships' do

    it { expect(theme).to belong_to(:category) }

  end

  context 'validations' do

    it { expect(theme).to validate_presence_of(:title) }

    it { expect(theme).to validate_presence_of(:content) }

    it { expect(theme).to validate_uniqueness_of(:title).case_insensitive }

  end

  describe '#capitalize_title' do

    before(:each) { theme.title = 'theme' }

    it 'makes the title attribute start with capital letter' do
      expect { theme.capitalize_title }.to change{ theme.title }.
          from('theme').
          to('Theme')
    end

    it 'capitalizes the title before saving' do
      expect(theme.save).to be_truthy
      expect(theme.title).to eq('Theme')
    end

  end
end
