require 'faker'
# Seeds for Tags
Tag.create(name: 'Android')
Tag.create(name: 'iOS')
Tag.create(name: 'Ruby on Rails')
Tag.create(name: 'Spring')

# Seeds for admins
User.create(email:'admin@aa.pl',name:'admin',surname:'admin',password:'admin',position:'admin',is_admin:true).confirm

for i in 0..40
	User.create(email:Faker::Internet.email,name: Faker::Name.last_name, surname:Faker::Name.first_name,password:Faker::Internet.password(8), position: Faker::Job.title, is_admin: false).confirm
end

#Seeds for Problems
for i in 0..500
 Problem.create(title: Faker::GreekPhilosophers.quote, content: Faker::GreekPhilosophers.name, reference_list: Faker::LordOfTheRings.character, creator_id: User.last.id, status: true, created_at: Faker::Date.between(2.months.ago, Date.today))
end