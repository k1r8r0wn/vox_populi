shared_examples 'not current_user' do

  it "redirects to 'index' page if user is not signed in" do
    expect(response).to redirect_to(new_user_session_path)
    expect(response.status).not_to eq(200)
  end

  it 'shows flash[:error] message' do
    expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
  end

end

shared_examples 'current_user' do |controller, action|

  before { sign_in(user) }

  unless "#{action}" == 'destroy'
    it "renders '#{action}' page if #{controller} are found" do
      if "#{controller}" == 'categories'
        get action, id: category
      else
        get action, category_id: category
      end
      expect(response).to render_template(action)
      expect(response.status).to eq(200)
    end
  end

  unless "#{action}" == 'new' || "#{action}" == 'new_separate'
    it "renders 404 page when #{controller} are not found" do
      if "#{controller}" == 'categories'
        get action, id: 0
      else
        get action, category_id: 0
      end
      expect(response.status).to eq(404)
    end
  end

end
