Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # for mailer ? 
  default_url_options :host => "http://localhost:3000/"

  root 'home#welcome'
end
