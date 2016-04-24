require 'rails_helper'

describe Category, type: :model do

  let(:category) { create(:category) }

  context 'relationships' do
    it { expect(category).to belong_to(:user) }

    it { expect(category).to have_many(:themes).dependent(:destroy) }
  end

  context 'validations' do
    it { expect(category).to validate_presence_of(:name) }

    it { expect(category).to validate_uniqueness_of(:name).case_insensitive }
  end

  describe '#capitalize_name' do
    before(:each) { category.name = 'category' }

    it 'makes the name attribute start with capital letter' do
      expect { category.capitalize_name }.to change{ category.name }.
        from('category').
        to('Category')
    end

    it 'capitalizes the name before saving' do
      expect(category.save).to be_truthy
      expect(category.name).to eq('Category')
    end
  end

end
