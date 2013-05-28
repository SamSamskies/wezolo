Wezolo::Application.routes.draw do
  resources :messages, :only => [:create, :index]
  get "profile/create"
  get "search/index"
  get "search/results", :to => "search#search_results"
  get "test" => "tumblr#show"
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

  match '/auth/tumblr/callback' => "tumblr#connect", :auth_provider => 'tumblr'
  match '/tumblr/disconnect/' => "tumblr#disconnect"

  post '/receive_callback' => "messages#receive_callback"

  match 'auth/blogger' => 'blogger#request_blogger_access'
  match '/auth/blogger/callback' => "blogger#authorize_blogger", :auth_provider => 'blogger'
  post "/tumblr/create_blog_and_posts" => "tumblr#create_blog_and_posts"
  post "/blogger/create_blog_and_posts" => "blogger#create_blog_and_posts"
  get 'blogger/new'
end
