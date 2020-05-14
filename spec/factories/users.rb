# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Tom' }
    email { 'tester@exmaple.com' }
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :other_user, class: User do
    name { 'Micheal' }
    email { 'tester2@exmaple.com' }
    password { 'password2' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :third_user, class: User do
    name { 'Patick' }
    email { 'tester3@exmaple.com' }
    password { 'password3' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :unactivated_user, class: User do
    name { 'Jobs' }
    email { 'tester3@exmaple.com' }
    password { 'password3' }
    activated { false }
    activated_at { nil }
  end

  factory :users, class: User do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password2s' }
    activated { true }
    activated_at { Time.zone.now }
  end
end
