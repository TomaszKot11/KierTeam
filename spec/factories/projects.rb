FactoryBot.define do
  factory :project do
    title Faker::Internet.username(3..80)
    description Faker::Internet.username(3..500)
    started_at "2018-07-17 13:35:54"
    ended_at "2018-07-17 13:35:54"
  end
end
