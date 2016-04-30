require 'features/features_helper'

describe 'Updating comments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  let!(:comment) { create(:comment, theme: theme, user: user) }

  def update_comment
    sign_in(user)
    visit category_theme_path(category, theme)
    find('.comment-edit').click
  end

  context 'Update comment' do
    describe 'Comment has content', js: true do
      before(:each) do
        update_comment
        within '.comment-form' do
          fill_in 'Content', with: 'I am an updated comment'
          click_button 'Update'
        end
      end

      it 'shows the new comment' do
        within '.comments-wrapper' do
          expect(page).to have_content('I am an updated comment')
        end
      end

      it 'displays the flash[:success] message' do
        expect(page).to have_content('Your comment is successfully updated!')
      end
    end

    describe 'Comment has no content', js: true do
      before do
        update_comment
        within '.comment-form' do
          fill_in 'Content', with: ''
          click_button 'Update'
        end
      end

      it 'displays the flash[:error] message' do
        expect(page).to have_content("Your comment's content can't be blank!")
        expect(page).to have_content(/Content/)
      end
    end
  end

  context 'Cancel update', js: true do
    before do
      update_comment
      within '.comment-form' do
        click_link 'Cancel'
      end
    end

    it "redirects to primary comment when 'cancel' button is clicked" do
      expect(page).not_to have_selector('.comment-form')
      expect(page).to have_selector('.comment-body')
    end
  end

  context "Can't edit comment if 5 minutes are left", js: true do
    before do
      update_comment
      comment.update(created_at: 5.minutes.ago)
      within '.comment-form' do
        fill_in 'Content', with: 'I am an updated comment'
        click_button 'Update'
      end
    end

    it 'displays the flash[:error] message' do
      comment.update(created_at: 5.minutes.ago)
      expect(page).to have_content('Comment can be updated only in 5 minutes after creation.')
    end
  end

end
