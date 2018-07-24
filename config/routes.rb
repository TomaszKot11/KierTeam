Rails.application.routes.draw do

  root 'home#welcome'

  get '/problems/search_problems', to: 'problems#search_problems', as: :problem_search
  get '/problems/add_contributor', to: 'problems#add_contributor', as: :add_contributor
  resources :problems
  resources :problems, only: [:destroy], as: :problem_remove

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :users, only: [:show, :index]

  resources :comments, only: [:create, :destroy]

  resources :tags, only: [:new, :create, :index, :destroy]
end
