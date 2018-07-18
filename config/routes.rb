Rails.application.routes.draw do
  
 # get 'users/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  default_url_options :host => "example.com"
  
  root 'home#welcome'

  devise_for :users, :controllers => { registrations: 'registrations'}


  get '/problems', to: 'problems#index', as: :problems

  # For logged in user to create new post
  get '/problems/new', to: 'problems#new_logged_user', as: :new_problem_user
  post '/problems', to: 'problems#create'

  # for post searching
  get '/problems/search_problems', to: 'problems#search_problems', as: :problem_search

  get '/problems/:id', to: 'problems#show', as: :problem


  get '/users/:id/', to: 'users#show', as: :user
  get '/users',   to: 'users#index', as: :users
  
  resources :users, only: [:show]
 


  get '/problem_users/new', to: 'problem_users#new', as: :add_collaborator


end
