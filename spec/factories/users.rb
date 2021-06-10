# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    first_name { "test" }
    last_name { "user" }
    sequence(:email) { |n| "test_#{n}@test.com" }
    password { "password" }

    trait :confirmed do
      confirmed_at { Time.now }
    end
  end
end
