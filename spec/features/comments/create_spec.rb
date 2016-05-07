require 'features/features_helper'

describe 'Creating comments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  before { sign_in(user) }

  def create_comment(options={})
    options[:content] ||= 'I am a comment'

    visit category_theme_path(category, theme)
    within '#new_comment' do
      fill_in "Comment's content", with: options[:content]
      click_button 'Submit'
    end
  end

  context 'Comment has content' do
    before(:each) { create_comment }

    it 'displays the added comment' do
      within '.comments-wrapper' do
        expect(page).to have_content('I am a comment')
      end
    end

    it "displays 'Leave your comment' message in comments form instead of 'Leave the first comment'" do
      expect(page).to have_content('Leave your comment')
    end

    it 'displays the flash[:success] message' do
      expect(page).to have_content('Comment is successfully added below!')
    end

    it 'hides the edit symbol due 5 minutes after comment was created' do
      Comment.last.update(created_at: 5.minutes.ago)
      visit category_theme_path(category, theme)
      expect(page).to have_no_css('.comment-edit')
    end

  end

  context 'Comment has no content' do
    it 'displays the flash[:error] message' do
      expect(Comment.count).to eq(0)

      create_comment content: ''

      expect(page).to have_content("Comment's content can't be blank!")
      expect(Comment.count).to eq(0)

      visit category_theme_path(category, theme)
      expect(page).to_not have_content('I am a comment')
    end
  end

end
