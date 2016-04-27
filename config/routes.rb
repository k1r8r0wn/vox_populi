Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :categories, except: [:show] do
    resources :themes do
      resources :comments, except: [:index, :show] do
        resources :subcomments, except: [:index, :show]
      end
    end
  end

  get 'themes/new' => 'themes#new_separate', as: :new_separate
  post 'themes/create' => 'themes#create_separate', as: :create_separate

  root 'pages#home'

  get '*path' => redirect('/')

end
