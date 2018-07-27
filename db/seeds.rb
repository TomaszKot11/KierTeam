require 'faker'


User.create(email:'admin@aa.pl',name:'admin',surname:'admin',password:'admin',position:'admin',is_admin:true).confirm
User.create(email: Faker::GreekPhilosophers.name, name: Faker::GreekPhilosophers.name, surname: Faker::GreekPhilosophers.name, is_admin: false, position: 'dev').confirm



case Rails.env
when 'development'

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

when 'production'
  Tag.create(name: 'Android')
  Tag.create(name: 'iOS')
  Tag.create(name: 'Ruby on Rails')
  Tag.create(name: 'Spring')
  Tag.create(name: 'Java')
  Tag.create(name: 'MySQL')

  Profession.create(name:'Android developer')
  Profession.create(name:'Rails developer')
  Profession.create(name:'Java developer')
  Profession.create(name:'Assembler developer')
  Profession.create(name:'Fortrun developer')
  Profession.create(name:'Pascal developer')

  User.create(name:"admin", surname:"admin", email:"admin@aa.pl",is_admin:true,password:"12qwaszx",profession_id:nil)

  User.create(name:"Thomas", surname:"Kowalsky", email:"thomas@aa.pl",password:"12qwaszx",profession_id:1)
  User.create(name:"Ruffy", surname:"Iksinsky", email:"ruffy@aa.pl",password:"12qwaszx",profession_id:2)
  User.create(name:"John", surname:"Cena", email:"jon@aa.pl",password:"12qwaszx",profession_id:3)

  for i in 0..10
    Problem.create(title: "Android #{i}", content: "Problem with Android #{i}", reference_list: 'Android references', status: true, created_at: Date.today, creator_id:1)
  end

  for i in 0..10
    Problem.create(title: "iOS #{i}", content: "Problem with iOS #{i}", reference_list: 'iOS references', status: true, created_at: Date.today, creator_id:2)
  end

  for i in 0..10
    Problem.create(title: "Ruby on Rails #{i}", content: "Problem with Ruby on Rails #{i}", reference_list: 'Ruby on Rails references', status: true, created_at: Date.today, creator_id:1)
  end


