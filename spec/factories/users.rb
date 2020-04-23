FactoryBot.define do
  factory :user do
    name "Tom"
    email "tester@exmaple.com"
    password "password"
  end

  factory :other_user, class: User do
    name "Micheal"
    email "tester2@exmaple.com"
    password "password2s"
  end

  factory :users, class: User do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password "password2s"
  end
end
