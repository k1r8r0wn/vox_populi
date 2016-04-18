Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :categories, except: [:show] do
    resources :themes
  end

  get 'themes/new' => 'themes#new_separate', as: :new_separate
  post 'themes/create' => 'themes#create_separate', as: :create_separate

  resources :themes do
    resources :comments, only: [:create]
  end

  root 'pages#home'

  get '*path' => redirect('/')

end
