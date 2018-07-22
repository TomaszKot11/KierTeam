FactoryBot.define do
  factory :tag do
    name {Faker::Company.name[1..80]}
  end
end
