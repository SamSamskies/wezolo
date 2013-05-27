Wezolo::Application.routes.draw do
  get "messages/index"
  get "messages/create"

  get "profile/create"
  get "search/index"
  get "search/results", :to => "search#search_results"
  resource :follows, :only => [:create, :destroy]
  resources :users
  resources :profiles, :only => [:edit, :update]
  resources :involvements, :only => [:new, :create, :edit, :update, :destroy]
  root :to => "home#landing"
  get '/home' => "home#home"
  post '/login' => 'session#create', :as => "login"
  delete '/logout' => 'session#destroy', :as => "logout"
  get '/signup' => 'users#new', :as => "signup"
  match '/auth/google_oauth2/callback' => "session#create", :auth_provider => 'google'
  # facebook callback route needs to have :auth_provider => 'facebook'
end
