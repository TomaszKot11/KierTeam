FactoryBot.define do
    factory :problem do
        title { Faker::Internet.username(5..80) }
        content { Faker::Internet.username(5..500) }
        # faker doesn't have any ulr generator
        reference_list 'www.google.com'
        association :creator, factory: :user
    end

    factory :problem_2, class: Problem do
        title { Faker::Internet.username(5..80) }
        content { Faker::Internet.username(5..500) }
        reference_list 'www.google.com'
        association :creator, factory: :user_1
    end
end
