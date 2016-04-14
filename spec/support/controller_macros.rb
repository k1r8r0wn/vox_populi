module ControllerMacros

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def current_user(action)
      context 'current_user' do
        before { sign_in(user) }

        unless "#{action}" == 'destroy'
          it 'renders action template if category is found' do
            get action, { id: category.id }
            expect(response).to render_template(action)
            expect(response.status).to eq(200)
          end
        end

        unless "#{action}" == 'new'
          it 'renders 404 page when category is not found' do
            get action, { id: 0 }
            expect(response.status).to eq(404)
          end
        end

      end
    end

    def not_current_user(action)
      context 'not current_user' do
        before { get action, { id: category.id } }

        it "renders 'index' page if user is not signed in" do
          expect(response).to redirect_to(new_user_session_path)
          expect(response.status).not_to eq(200)
        end

        it 'shows flash[:error] message' do
          expect(flash[:alert]).to eq('You need to sign in or sign up before continuing.')
        end

      end
    end

  end

end
