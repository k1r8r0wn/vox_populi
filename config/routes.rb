Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :categories, except: [:show] do
    resources :themes do
      member do
        post 'vote_for'
        post 'vote_against'
        delete 'revote'
      end
      resources :comments, except: [:index, :show] do
        resources :subcomments, except: [:index, :show]
      end
    end
  end

  root 'pages#home'

  get 'themes/new', to: 'themes#new_separate', as: :new_separate
  post 'themes/create', to: 'themes#create_separate', as: :create_separate

  get '/statistics', to: 'pages#statistics', as: :statistics

  get '/change_locale/:locale', to: 'sessions#change_locale', as: :change_locale

  get '*path', to: redirect('/')

end
