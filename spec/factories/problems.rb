FactoryBot.define do
  factory :problem do
    title 'MyString'
    content 'MyString'
    references 'MyString'
    association :creator, factory: :user
  end
end
