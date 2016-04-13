Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :themes, only: [:index, :show, :new, :create]
  end

  get 'themes/new' => 'themes#new_separate', as: :new_separate
  post 'themes/create' => 'themes#create_separate', as: :create_separate

  root 'pages#home'

  get '*path' => redirect('/')

end
