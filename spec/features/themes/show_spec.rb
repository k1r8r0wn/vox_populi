require 'rails_helper'

describe 'Showing comments' do

  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:theme) { create(:theme, category: category) }

  shared_examples_for 'posted comment' do

    it 'displays posted comment' do
      within '.comments-wrapper' do
        expect(page).to have_content(/Content/)
      end
    end

  end

  context 'there is no comments' do

    describe 'current_user' do

      before do
        sign_in(user)
        visit category_theme_path(category, theme)
      end

      it "displays 'Leave the first comment' message" do
        within '.comment-form' do
          expect(page).to have_content('Leave the first comment')
        end
      end

    end

  end

  context 'there is a comment' do
    let!(:comment) { create(:comment, theme: theme ) }

    describe 'not_current_user' do

      before { visit category_theme_path(category, theme) }

      it_behaves_like 'posted comment'

      it "displays the 'Want to leave comments? Sign in or Sign up.' message" do
        within '.comment-form' do
          expect(page).to have_content('Want to leave comments? Sign in or Sign up.')
        end
      end

    end

    describe 'current_user' do

      before do
        sign_in(user)
        visit category_theme_path(category, theme)
      end

      it_behaves_like 'posted comment'

      it "displays 'Leave your comment' comment" do
        within '.comment-form' do
          expect(page).to have_content('Leave your comment')
        end
      end

    end

  end

end
