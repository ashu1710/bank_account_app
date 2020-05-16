Rails.application.routes.draw do
  devise_for :users, :controllers => { passwords: 'users/passwords', registrations: 'users/registrations' }
  get '/withdraw', to: 'transactions#withdraw'
  get '/transfer', to: 'transactions#transfer'
  get '/deposit', to: 'transactions#deposit'
  resources :transactions, only: [:create, :index]
  resources :cards, only: [:create]
  resources :accounts, only: [:create]

  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
