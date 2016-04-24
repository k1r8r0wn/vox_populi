require 'rails_helper'

describe PagesController, type: :controller do

  describe 'GET #home' do

    it "renders 'home' page" do
      get :home
      expect(response).to render_template('layouts/home')
      expect(response).to render_template('home')
      expect(response.status).to eq(200)
    end

  end

end
