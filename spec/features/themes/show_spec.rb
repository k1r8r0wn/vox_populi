require 'features/features_helper'

describe 'Theme', type: :feature do

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

  describe 'Showing comments' do
    context 'there is no comments' do
      describe 'current_user' do
        before do
          sign_in(user)
          visit category_theme_path(category, theme)
        end

        it "displays 'Leave the first comment' message" do
          within '.comments-wrapper' do
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
          within '.comments-wrapper' do
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
          within '.comments-wrapper' do
            expect(page).to have_content('Leave your comment')
          end
        end
      end
    end
  end

  describe 'Voting' do
    context 'not current_user' do
      it 'hides theme votes' do
        visit category_theme_path(category, theme)
        expect(page).not_to have_content('How is this problem for you?')
      end
    end

    context 'current_user' do
      before do
        sign_in(user)
        visit category_theme_path(category, theme)
      end

      it 'displays theme votes' do
        expect(page).to have_content('How is this problem for you?')
      end

      it 'adds 1 vote to theme' do
        within '.votes' do
          find('.glyphicon-thumbs-up').click
        end
        expect(user.voted_on?(theme)).to eq(true)
        expect(theme.votes_for).to eq(1)
      end

      it 'substracts 1 vote from theme' do
        within '.votes' do
          find('.glyphicon-thumbs-down').click
        end
        expect(user.voted_on?(theme)).to eq(true)
        expect(theme.votes_against).to eq(1)
      end

      it 'deletes the vote on revote' do
        within '.votes' do
          find('.glyphicon-thumbs-up').click
        end
        visit category_theme_path(category, theme)
        within '.votes' do
          find('.revote').click
        end
        expect(user.voted_on?(theme)).to eq(false)
        expect(theme.votes_for).to eq(0)
      end
    end
  end

end
