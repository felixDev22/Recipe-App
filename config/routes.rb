Rails.application.routes.draw do
  devise_for :users
       root to: "foods#index"
       resources :recipe_foods
       resources :recipes
       resources :foods, only: [:index, :new, :create, :destroy]
end
