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

categories = %w[遺伝学 医学 化学 環境学 経済学 古生物学 昆虫学 細胞学 植物学 水産学 天文学 動物学 文学]

categories.each {|category| Category.create(name: category)}