FactoryBot.define do
  factory :comment do
    content "Good!"
    association :article
    user { article.user }
  end

  factory :comments, class: Comment do
    sequence(:content) { |n| "Very good#{n}" }
    sequence(:created_at) {|n| n.day.ago }
  end
end
