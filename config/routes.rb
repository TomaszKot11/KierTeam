Rails.application.routes.draw do

  root 'home#welcome'

  get '/problems/search_problems', to: 'problems#search_problems', as: :problem_search
  get '/problems/add_contributor', to: 'problems#add_contributor', as: :add_contributor

  get 'problems/filter', to: 'problems#filter_search_results', as: :filter_results

  resources :problems
  resources :problems, only: [:destroy], as: :problem_remove
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
 
  resources :users, only: [:show, :index, :destroy]
  put 'users/:id', to: 'users#ban'

  resources :comments, only: [:create, :destroy]

  resources :tags, only: [:create, :index, :destroy, :update, :edit]

  resources :professions, only: [:create, :index, :destroy, :update, :edit]

  # for help request mail
  get :send_help_request, to: 'problems#send_help_request', as: :send_help_request

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
