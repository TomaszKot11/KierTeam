FactoryBot.define do
  factory :user do
    email "example@example.com"
    password "password"
    password_confirmation "password"
    name "John"
    surname "Kovalsky"
    position "white-collar worker"
  end
end
