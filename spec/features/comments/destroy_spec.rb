require 'features/features_helper'

describe 'Deleting comments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  let!(:comment) { create(:comment, theme: theme, user: user) }

  before(:each) do
    sign_in(user)
    visit category_theme_path(category, theme)
    find('.comment-delete').click
    page.execute_script('window.confirm = function() { return true }')
  end

  it 'deletes comment after clicking delete link', js: true do
    within ('.comments-wrapper') do
      expect(page).to_not have_content(comment.content)
    end
    expect(Comment.count).to eq(0)
  end

  it 'displays the flash[:success] message', js: true do
    expect(page).to have_content('This comment is successfully deleted!')
  end

end
