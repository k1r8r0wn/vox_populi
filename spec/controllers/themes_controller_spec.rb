require 'rails_helper'

RSpec.describe ThemesController, type: :controller do

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:theme) { create(:theme, category: category) }

  describe 'GET #index' do

    it "renders 'index' page if themes are found" do
      get :index, category_id: category
      expect(response).to render_template('index')
      expect(response.status).to eq(200)
    end

  end

  describe 'GET #new' do

    # support/shared_examples.rb
    it_should_behave_like 'current_user', 'themes', 'new'

    before { get :new, category_id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'GET #new_separate' do

    # support/shared_examples.rb
    it_should_behave_like 'current_user', 'themes', 'new_separate'

    before { get :new_separate, category_id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'GET #show' do

    it "renders 'show' page if theme is found" do
      get :show, category_id: category, id: theme
      expect(response).to render_template('show')
      expect(response.status).to eq(200)
    end

    it 'renders 404 page when themes are not found' do
      get :show, category_id: 0, id: 0
      expect(response.status).to eq(404)
    end

  end

  describe 'GET #edit' do

    context 'current_user' do
      before { sign_in(user) }

      it "renders 'edit' page if theme is found" do
        get :edit, category_id: category, id: theme
        expect(response).to render_template('edit')
        expect(response.status).to eq(200)
      end

      it 'renders 404 page when themes are not found' do
        get :edit, category_id: 0, id: 0
        expect(response.status).to eq(404)
      end

    end

    before { get :edit, category_id: category, id: theme }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'POST #create' do

    before { post :create, category_id: category, theme: { title: 'Theme', content: 'Content' } }

    context 'current_user' do
      before { sign_in(user) }
      before { post :create, category_id: category, theme: { title: 'Theme', content: 'Content' } }

      it 'redirects to created theme if validations pass' do
        theme = category.themes.first
        expect(response).to redirect_to(category_theme_path(category, theme))
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Theme 'Theme' is successfully created!")
      end

      it "renders 'new' page again if validations fail" do
        post :create, category_id: category, theme: { title: nil, content: 'Content' }
        expect(response).to render_template('new')
      end

    end

    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'POST #create_separate' do

    before { post :create_separate, theme: { category_id: category, title: 'Theme', content:
        'Content' } }

    context 'current_user' do
      before { sign_in(user) }
      before { post :create_separate, theme: { category_id: category, title: 'Theme', content: 'Content' } }

      it 'redirects to created theme if validations pass' do
        theme = category.themes.first
        expect(response).to redirect_to(category_theme_path(category, theme))
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Theme 'Theme' is successfully created!")
      end

      it "renders 'new' page again if validations fail" do
        post :create_separate, theme: { category_id: category, title: nil, content: 'Content' }
        expect(response).to render_template('new_separate')
      end

    end

    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'PUT, PATCH #update' do

    before { put :update, category_id: category, id: theme, theme: { title: 'Theme2', content: 'Content' } }

    context 'current_user' do
      before { sign_in(user) }
      before { put :update, category_id: category, id: theme, theme: {title: 'Theme2', content: 'Content' } }

      it 'redirects to updated theme if validations pass' do
        expect(response).to redirect_to(category_theme_path(category, theme))
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Theme 'Theme2' is successfully updated!")
      end

      it "renders 'new' page again if validations fail" do
        put :update, category_id: category, id: theme, theme: { title: nil }
        expect(response).to render_template('edit')
      end

    end

    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'DELETE #destroy' do

    context 'current_user' do
      before { sign_in(user) }

      it 'redirects to categories themes path when the theme is destroyed successfully' do
        delete :destroy, category_id: category, id: theme
        expect(response).to redirect_to(category_themes_path)
      end

    end

    before { get :edit, category_id: category, id: theme }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

end
