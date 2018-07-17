FactoryBot.define do
  factory :user do
    email "example@example.com"
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
    name "John"
    surname "Kovalsky"
    position "white-collar worker"
  end
end
