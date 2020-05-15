# frozen_string_literal: true

FactoryBot.define do
  factory :fishery, class: Category do
    name '水産学'
  end

  factory :zoology, class: Category do
    name '動物学'
  end

  factory :environmentology, class: Category do
    name '環境学'
  end

  factory :medicine, class: Category do
    name '医学'
  end
end
