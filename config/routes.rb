Rails.application.routes.draw do
  resources :camps
  resources :cities
  resources :regions
  resources :countries

  root 'camps#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
