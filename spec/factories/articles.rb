# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title 'Title'
    content 'Very interesting research'
    citation 'Nature 1999, Vol 20'
    created_at Time.zone.now
    association :user

    factory :article_last_year do
      title 'Last Year'
      created_at 1.year.ago
    end

    factory :article_last_month do
      title 'Last Month'
      created_at 1.month.ago
    end

    factory :article_2_days_ago do
      title 'Two days ago'
      created_at 2.days.ago
    end

    factory :article_today do
      title 'Today'
      created_at Time.zone.now
    end
  end

  factory :articles, class: Article do
    sequence(:title) { |n| "title#{n}" }
    sequence(:citation) { |n| "Book vol.#{n}" }
    sequence(:content) { |n| "content#{n}" }
  end
end
