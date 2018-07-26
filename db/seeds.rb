# Seeds for Tags
Tag.create(name: 'Android')
Tag.create(name: 'iOS')
Tag.create(name: 'Ruby on Rails')
Tag.create(name: 'Spring')

# Seeds for admins
User.create(email:'admin@aa.pl',name:'admin',surname:'admin',password:'admin',position:'admin',is_admin:true).confirm
