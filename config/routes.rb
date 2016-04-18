Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  resources :categories, except: [:show] do
    resources :themes
  end

  get 'themes/new' => 'themes#new_separate', as: :new_separate
  post 'themes/create' => 'themes#create_separate', as: :create_separate

  resources :themes, only: [:index] do
    resources :comments, only: [:new, :create]
  end

  resources :comments,  only: [:index] do
    resources :comments, only: [:new, :create]
  end

  root 'pages#home'

  get '*path' => redirect('/')

end
