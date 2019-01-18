Rails.application.routes.draw do
  resources :recipes do
    resources :instructions
  end
  devise_for :users, skip: [:registrations]
  as :user do
  get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
  #get "/sign_up" => "devise/registrations#new", as: "new_user_registration" # custom path to sign_up/registration
  get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
  put 'users' => 'devise/registrations#update', :as => 'user_registration'
end

  delete 'recipes/:id/delete_picture', to: 'recipes#delete_picture', as: 'recipe_delete_picture'

  root "recipes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
