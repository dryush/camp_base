Rails.application.routes.draw do
  resources :camps
  resources :cities
  resources :regions
  resources :countries

  get 'regions/:country_id/' , to: 'regions#index'
  get 'cities/:region_id/' , to: 'regions#index'

  root 'camps#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
