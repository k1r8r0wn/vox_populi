require 'rails_helper'

describe 'Creating comments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  before { sign_in(user) }

  def create_comment(options={})
    options[:content] ||= 'I am a comment'

    visit category_theme_path(category, theme)
    within '.comment-form' do
      fill_in 'Content', with: options[:content]
      click_button 'Submit'
    end
  end

  context 'Comment has content' do
    before(:each) { create_comment }

    it 'shows the added comment' do
      within '.comments-wrapper' do
        expect(page).to have_content('I am a comment')
      end
    end

    it "shows 'Leave your comment' message in comments form instead of 'Leave the first comment'" do
      within '.comment-form' do
        expect(page).to have_content('Leave your comment')
      end
    end

    it 'displays the flash[:success] message' do
      expect(page).to have_content('Your comment is successfully added below!')
    end

  end

  context 'Comment has no content' do

    it 'displays the flash[:error] message' do
      expect(Comment.count).to eq(0)

      create_comment content: ''

      expect(page).to have_content("Your comment's content can't be blank!")
      expect(Comment.count).to eq(0)

      visit category_theme_path(category, theme)
      expect(page).to_not have_content('I am a comment')
    end
  end

end
