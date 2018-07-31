FactoryBot.define do
  factory :tag do
    name { Faker::Company.name[1..80] }
  end

  factory :tag_1, class: Tag do
    name { Faker::Company.name[1..80] }
  end
end
