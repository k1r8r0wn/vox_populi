require 'rails_helper'

describe CategoriesController, type: :controller do

  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'GET #index' do

    it "renders 'index' page if categories are found" do
      get :index, id: category
      expect(response).to render_template('index')
      expect(response.status).to eq(200)
    end

  end

  describe 'GET #new' do

    # support/shared_examples.rb
    it_should_behave_like 'current_user', 'categories', 'new'

    before { get :new, id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'GET #edit' do

    # support/shared_examples.rb
    it_should_behave_like 'current_user', 'categories', 'edit'

    before { get :edit, id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'POST #create' do

    context 'current_user' do

      before { sign_in(user) }
      before { post :create, category: { name: 'Test' } }

      it 'redirects to categories path if validations pass' do
        expect(response).to redirect_to(categories_path)
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Category 'Test' is successfully created!")
      end

      it "renders 'new' page again if validations fail" do
        post :create, category: { name: nil }
        expect(response).to render_template('new')
      end

    end

    before { get :create, id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'PUT, PATCH #update' do

    context 'current_user' do

      before { sign_in(user) }
      before { put :update, id: category, category: { name: 'Test2' } }

      it 'redirects to categories path if validations pass' do
        expect(response).to redirect_to(category_themes_path(category))
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Category 'Test2' is successfully updated!")
      end

      it "renders 'edit' page again if validations fail" do
        put :update, id: category, category: { name: nil }
        expect(response).to render_template('edit')
      end

    end

    before { get :update, id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

  describe 'DELETE #destroy' do

    context 'current_user' do
      before { sign_in(user) }

      it 'redirects to categories path when the category is destroyed successfully' do
        delete :destroy, id: category
        expect(response).to redirect_to(categories_path)
      end

    end

    before { get :destroy, id: category }
    # support/shared_examples.rb
    it_should_behave_like 'not current_user'

  end

end
