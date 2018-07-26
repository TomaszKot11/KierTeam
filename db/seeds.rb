# Seeds for Tags
Tag.create(name: 'Android')
Tag.create(name: 'iOS')
Tag.create(name: 'Ruby on Rails')
Tag.create(name: 'Spring')

# Seeds for admins
User.create(email:'admin@aa.pl',name:'admin',surname:'admin',password:'admin',position:'admin',is_admin:true).confirm

#Seeds for Problems
for i in 0..500
 Problem.create(title: Faker::GreekPhilosophers.quote, content: Faker::GreekPhilosophers.name, references: Faker::LordOfTheRings.character, creator_id: User.last.id, status: true, created_at: Faker::Date.between(2.months.ago, Date.today))
end