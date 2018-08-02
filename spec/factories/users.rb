FactoryBot.define do
    factory :user do
        email { Faker::Internet.email }
        password "password"
        password_confirmation "password"
        name { Faker::Company.name[3..80] }
        surname { Faker::Company.name[3..80] }
        association :profession, factory: :profession
        blocked false
    end

    factory :user_1, class: User do
        email { Faker::Internet.email }
        password "password"
        password_confirmation "password"
        name { Faker::Company.name[3..80] }
        surname { Faker::Company.name[3..80] }
        association :profession, factory: :profession
        blocked false
    end
end
