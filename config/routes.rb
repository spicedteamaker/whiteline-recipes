Rails.application.routes.draw do
  resources :recipes do
    resources :instructions
  end
  devise_for :users

  delete 'recipes/:id/delete_picture', to: 'recipes#delete_picture', as: 'recipe_delete_picture'

  root "recipes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
