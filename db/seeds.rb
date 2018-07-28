require 'faker'

Profession.create(name: 'Android Developer')
Profession.create(name: 'iOS Developer')
User.create(email:'admin@aa.pl', name:'admin', surname:'admin', password:'admin', profession_id:Profession.last, is_admin:true).confirm
User.create(email: Faker::GreekPhilosophers.name, name: Faker::GreekPhilosophers.name, surname: Faker::GreekPhilosophers.name, is_admin: false, profession_id: Profession.last).confirm

  Tag.create(name: 'Android')
  Tag.create(name: 'iOS')
  Tag.create(name: 'Ruby on Rails')
  Tag.create(name: 'Spring')

  #Seeds for Problems
  for i in 0..500
  Problem.create(title: Faker::GreekPhilosophers.quote, content: Faker::GreekPhilosophers.name, reference_list: Faker::LordOfTheRings.character, creator_id: User.last.id, status: true, created_at: Faker::Date.between(2.months.ago, Date.today), creator_id: User.last.id)
  end


  for i in 0..10
    Problem.create(title: "Android #{i}", content: "Problem with Android #{i}", reference_list: 'Android references', status: true, created_at: Date.today, creator_id: User.first.id)
  end

  for i in 0..10
    Problem.create(title: "iOS #{i}", content: "Problem with iOS #{i}", reference_list: 'iOS references', status: true, created_at: Date.today, creator_id: User.first.id)
  end

  for i in 0..10
    Problem.create(title: "Ruby on Rails #{i}", content: "Problem with Ruby on Rails #{i}", reference_list: 'Ruby on Rails references', status: true, created_at: Date.today, creator_id: User.first.id)
  end


  for i in 0..10
    Problem.create(title: "Android #{i}", content: "Problem with Android #{i}", reference_list: 'Android references', status: true, created_at: Date.today, creator_id: User.first.id)
  end

  for i in 0..10
    Problem.create(title: "iOS #{i}", content: "Problem with iOS #{i}", reference_list: 'iOS references', status: true, created_at: Date.today, creator_id: User.first.id)
  end