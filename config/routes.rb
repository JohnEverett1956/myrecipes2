Rails.application.routes.draw do
  root "pages#home"
  get "pages/home", to: "pages#home"
  
 #resources :recipes
 #get "/recipes", to: "recipes#index"
 #get "/recipes/new", to: "recipes#new", as: "new_recipe"
 #get "/recipes/:id", to: "recipes#show", as: "recipe"
 #post "/recipes", to: "recipes#create"
 resources :recipes
 get "/signup", to: "chefs#new" 
 resource :chefs, except: [:new]
end
