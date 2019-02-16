Rails.application.routes.draw do
  resources :material_brands
  resources :condition_details
  resources :templates
  resources :designs
  resources :colors
  resources :clothing_brands

  get '/logout' => 'main#logout'

  root 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
