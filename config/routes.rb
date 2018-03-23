Rails.application.routes.draw do
  resources :camps
  resources :cities
  resources :regions
  resources :countries

  get 'countries/getAll' , to: 'countries#getAll'
  root 'camps#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
