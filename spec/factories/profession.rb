FactoryBot.define do
  factory :profession do
    name { Faker::Crypto.sha256[1..80] }
  end
end
