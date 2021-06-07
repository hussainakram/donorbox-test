# frozen_string_literal: true
FactoryBot.define do
  factory :task do
    status { 0 }
    sequence(:title) { |n| "Test - #{n}" }
    user { create(:user) }
  end
end
