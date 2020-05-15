# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    association :article
    user { article.user }
  end
end
