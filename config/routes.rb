Rails.application.routes.draw do

  root 'home#welcome'

  get '/problems/search_problems', to: 'problems#search_problems', as: :problem_search
  get '/problems/add_contributor', to: 'problems#add_contributor', as: :add_contributor
  #match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

  resources :problems
  resources :problems, only: [:destroy], as: :problem_remove

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show, :index, :destroy]
  resources :comments, only: [:create, :destroy]

  resources :tags, only: [:create, :index, :destroy, :update, :edit]

  resources :professions, only: [:create, :index, :destroy, :update, :edit]
end
