Rails.application.routes.draw do
  get 'regulation/new'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "products#index"
  resources :trials, only: [:index,:create,:new]
  resources :users 
  resources :regulation
end
