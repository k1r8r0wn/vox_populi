require 'rails_helper'

describe Comment, type: :model do

  let(:comment) { create(:comment) }

  context 'relationships' do

    it { expect(comment).to belong_to(:user) }

    it { expect(comment).to belong_to(:theme) }

  end

  context 'validations' do

    it { expect(comment).to validate_presence_of(:content) }

  end

end
