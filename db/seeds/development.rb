# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "First User", 
            email: "first@example.com",
            password: "password",
            password_confirmation: "password",
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name = "#{Faker::Name.name}#{n}"
  email = "example#{n+1}@example.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

user = User.find(1)
50.times do
  title = Faker::Lorem.sentence(10)
  user.articles.create!(title: title, content: "test")
end

users = User.all
users = users[2..30]
users.each do |user|
  10.times do
    title = Faker::Lorem.sentence(10)
    user.articles.create!(title: title, content: "test")
  end
end


user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed)}
followers.each { |follower| follower.follow(user)}

categories = %w[生態学 行動学 植物学 疫学 工学 水産学 環境学 医学 薬学]

categories.each {|category| Category.create(name: category)}


