Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#welcome'

  resources :users do
    resources :likes, only: [:index]
  end

  resources :users do
    resources :recipes do
      resources :likes, only: [:index]
      post '/likes', to: 'likes#create_or_update'
    end
  end

  resources :recipes do
    resources :likes, only: [:index]
  end

  resources :recipes do
    resources :ingredients
  end

  resources :ingredients

  get 'ingredients/:ingredient_id/recipes', to: 'recipe_ingredients#index'

  resources :sessions, only: [:new, :create, :destroy]
  get '/auth/:provider/callback', to: 'sessions#facebook'

  get 'recipe_ingredient_new', to: 'recipes#recipe_ingredient_new'
end
