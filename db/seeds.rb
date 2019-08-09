# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Marius",
             email: "marius@gmail.com",
             password:              "marius",
             password_confirmation: "marius",
             speak: "German",
             offer: "Japanese",
<<<<<<< HEAD
             place: "Germany",
=======
             place: "Berlin",
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
             age: 34)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  speak = Faker::Nation.nationality
<<<<<<< HEAD
  offer = Faker::Nation.language 
  place = Faker::Address.city
  age = Faker::Number.within(range: 1..99)
=======
  offer = Faker::Nation.language
  place = Faker::Address.city
  age = Faker::Number.between(1, 99)
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               speak: speak,
               offer: offer,
               place: place,
               age: age)
end

users = User.order(:created_at).take(6)
50.times do
<<<<<<< HEAD
	title = Faker::Lorem.sentence(word_count: 2)
  content = Faker::Lorem.sentence
=======
  title = Faker::Lorem.sentence(3, true, 4)
  content = Faker::Lorem.sentence(5)
>>>>>>> 72aa981102d525f0f93f0c887601db612ffc8fc3
  users.each { |user| user.messages.create!(title: title, content: content) }
end

users = User.all
user  = users.first
followings = users[2..50]
followers = users[3..40]
followings.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }