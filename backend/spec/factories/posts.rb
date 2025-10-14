# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    user_partition { rand(16) }  # User partition should be 0-15

    before(:create) do |post|
      post.user_partition = post.user_id % 16 if post.user.present?
    end
  end
end