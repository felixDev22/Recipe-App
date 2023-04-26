Rails.application.routes.draw do
  root "foods#index"
  devise_for :users
  resources :users
  resources :recipe_foods
  resources :recipes
  resources :foods, only: [:destroy,:index,:show,:new,:create]
end