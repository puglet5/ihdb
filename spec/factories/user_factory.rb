# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    password { '123456' }
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
