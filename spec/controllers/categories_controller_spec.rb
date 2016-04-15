require 'rails_helper'

describe CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe 'GET #index' do

    it "renders 'index' page if category is found" do
      get :index, id: category.id
      expect(response).to render_template('index')
    end

  end

  describe 'GET #new' do

    # support/controller_macros.rb
    current_user(:categories, :new)
    not_current_user(:categories, :new)

  end

  describe 'GET #edit' do

    # support/controller_macros.rb
    current_user(:categories, :edit)
    not_current_user(:categories, :edit)

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

    # support/controller_macros.rb
    not_current_user(:categories, :create)

  end

  describe 'PUT, PATCH #update' do

    context 'current_user' do

      before { sign_in(user) }
      before { put :update, id: category.id, category: { name: 'Test2' } }

      it 'redirects to categories path if validations pass' do
        expect(response).to redirect_to(category_themes_path(category))
      end

      it 'shows flash[:success] message' do
        expect(flash[:success]).to eq("Category 'Test2' is successfully updated!")
      end

      it "renders 'edit' page again if validations fail" do
        put :update, id: category.id, category: { name: nil }
        expect(response).to render_template('edit')
      end

    end

    # support/controller_macros.rb
    not_current_user(:categories, :create)

  end

  describe 'DELETE #destroy' do

    context 'current_user' do
      before { sign_in(user) }

      it 'redirects to categories path when the category is destroyed successfully' do
        delete :destroy, id: category.id
        expect(response).to redirect_to(categories_path)
      end

    end

    # support/controller_macros.rb
    current_user(:categories, :destroy)
    not_current_user(:categories, :create)

  end

end
