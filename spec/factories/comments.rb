FactoryBot.define do
  factory :comment do
    title {Faker::Company.name[5..80]}
    content {Faker::Company.name[5..500]}
    references {Faker::Company.name[5..500]}
    problem_id 1
  end
end
