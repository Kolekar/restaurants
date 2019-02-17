# frozen_string_literal: true

FactoryGirl.define do
  factory :restaurant do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:phone) { |n| "1234567890#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
