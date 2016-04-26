require 'features/features_helper'

describe 'Creating subcomments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  let!(:comment) { create(:comment, theme: theme ) }
  before { sign_in(user) }

  def create_subcomment
    visit category_theme_path(category, theme)
    find('.comment-reply').click
  end

  context 'Subcomment has content', js: true do
    before(:each) do
      create_subcomment
      within '.reply_comment-form' do
        fill_in 'Content', with: 'I am a subcomment'
        click_button 'Reply'
      end
    end

    it 'displays the added comment' do
      within '.comments-wrapper' do
        expect(page).to have_content('I am a subcomment')
      end
    end

    it 'displays the flash[:success] message' do
      expect(page).to have_content('Your comment is successfully added below!')
    end
  end

  context 'Subcomment has no content', js: true  do
    it 'displays the flash[:error] message' do
      expect(Comment.count).to eq(1)

      create_subcomment
      within '.reply_comment-form' do
        fill_in 'Content', with: ''
        click_button 'Reply'
      end

      expect(page).to have_content("Your comment's content can't be blank!")
      expect(Comment.count).to eq(1)

      visit category_theme_path(category, theme)
      expect(page).to_not have_content('I am a subcomment')
    end
  end

  context 'Due 5 minutes after subcomment was created', js: true do
    before do
      create_subcomment
      within '.reply_comment-form' do
        fill_in 'Content', with: 'I am a subcomment'
        click_button 'Reply'
      end
      visit category_theme_path(category, theme)
      comment.subcomments.first.update(created_at: 5.minutes.ago)
    end

    it 'hides the edit symbol' do
      visit category_theme_path(category, theme)
      within '.child-comment' do
        expect(page).to have_no_css('.comment-edit')
      end
    end
  end

end
