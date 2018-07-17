Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  default_url_options :host => "example.com"
  
  root 'home#welcome'

  # For logged in user to create new post
  get '/problems/new', to: 'problems#new_logged_user', as: :new_problem_user
  post '/problems', to: 'problems#create'

end
