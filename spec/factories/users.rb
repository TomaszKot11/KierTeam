FactoryBot.define do
  factory :user do
    email "example@example.com"
    password "password"
    password_confirmation "password"
    name "John"
    surname "Kovalsky"
    position "white-collar worker"
  end

  factory :user_1, class: User do
    email "example1@example.com"
    password "password"
    password_confirmation "password"
    name "John"
    surname "Kovalsky"
    position "white-collar worker"
  end 
end
