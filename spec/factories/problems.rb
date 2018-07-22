FactoryBot.define do
  factory :problem do
    title 'MyString'
    content 'MyString'
    references 'MyString'
	  association :creator, factory: :user
  end

  factory :problme_2, class: Problem do 
    title 'MyString2'
    content 'MyString2'
    references 'MyString2'
    association :creator, factory: :user_1
  end
end
