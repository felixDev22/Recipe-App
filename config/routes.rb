Rails.application.routes.draw do
  devise_for :users
  resources :foods, only: [:index, :new, :create, :destroy]
  resources :recipes, only: [:index, :show, :destroy, :new, :create] do
     resources :recipe_foods, only: [:new, :create, :destroy]
     resources :general_shopping_list, only: [:index ,:show]
  end

  match 'recipes/:recipe_id' => 'recipes#toggle_public', as: :toggle_public, via: :patch

  root "home#index"
end
