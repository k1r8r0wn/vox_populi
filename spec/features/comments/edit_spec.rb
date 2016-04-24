require 'features/features_helper'

describe 'Editing comments', type: :feature do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }
  let!(:comment) { create(:comment, theme: theme ) }

  before do
    sign_in(user)
    visit category_theme_path(category, theme)
  end

  it 'shows the editing form', js: true do
    find('.comment-edit').click
    expect(page).to have_css('.comment-form')
  end

end