Rails.application.routes.draw do
  get 'public_recipes/index'
  devise_for :users
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :destroy, :new, :create] do
     resources :recipe_foods, only: [:new, :create, :destroy]
     resources :general_shopping_list, only: [:index ,:show]
  end

  match 'recipes/:recipe_id' => 'recipes#toggle_public', as: :toggle_public, via: :patch
  get 'public_recipes', to: 'public_recipes#index'
  post 'shopping_list/recipe_id=:recipe_id', to: 'recipes#generate_list', as: 'generate_shopping_list'
  get 'shopping_list/recipe_id=:recipe_id', to: 'recipes#generate', as: "shopping_list"

  root "home#index"
end
