require 'rails_helper'

describe Comment, type: :model do

  let(:comment) { create(:comment) }

  context 'relationships' do

    it { expect(comment).to have_many(:comments).dependent(:destroy)}

    it { expect(comment).to belong_to(:commentable).dependent(:destroy) }

    it { expect(comment).to belong_to(:user) }

  end

  context 'validations' do

    it { expect(comment).to validate_presence_of(:content) }

    it { expect(comment).to validate_length_of(:content).is_at_most(500) }

  end

end
