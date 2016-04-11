Rails.application.routes.draw do

  devise_for :users

  resources :categories, only: [:index] do
    resources :themes
  end

  root 'pages#home'

  get '*path' => redirect('/')

end
