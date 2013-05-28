Wezolo::Application.routes.draw do
  resources :messages, :only => [:create, :index]
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

  match '/auth/tumblr/callback' => "tumblr#new", :auth_provider => 'tumblr'
  resources :blogs
  post '/receive_callback' => "messages#receive_callback"
  # match '/auth/tumblr/callback' => 'session#tumblr'
  # facebook callback route needs to have :auth_provider => 'facebook'
end
