# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    association :post, factory: :post
    body { Faker::Lorem.paragraph }
  end
end