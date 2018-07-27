require 'faker'

User.create(email:'admin@aa.pl',name:'admin',surname:'admin',password:'admin',position:'admin',is_admin:true).confirm

case Rails.env
when 'development'
  Tag.create(name: 'Android')
  Tag.create(name: 'iOS')
  Tag.create(name: 'Ruby on Rails')
  Tag.create(name: 'Spring')

  #Seeds for Problems
  for i in 0..500
  Problem.create(title: Faker::GreekPhilosophers.quote, content: Faker::GreekPhilosophers.name, reference_list: Faker::LordOfTheRings.character, creator_id: User.last.id, status: true, created_at: Faker::Date.between(2.months.ago, Date.today))
  end
when 'production'
  Tag.create(name: 'Android')
  Tag.create(name: 'iOS')
  Tag.create(name: 'Ruby on Rails')
  Tag.create(name: 'Spring')

  for i in 0..10
    Problem.create(title: "Android #{i}", content: "Problem with Android #{i}", reference_list: 'Android references', status: true, created_at: Date.today)
  end

  for i in 0..10
    Problem.create(title: "iOS #{i}", content: "Problem with iOS #{i}", reference_list: 'iOS references', status: true, created_at: Date.today)
  end

  for i in 0..10
    Problem.create(title: "Ruby on Rails #{i}", content: "Problem with Ruby on Rails #{i}", reference_list: 'Ruby on Rails references', status: true, created_at: Date.today)
  end
end

