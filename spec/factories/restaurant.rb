# frozen_string_literal: true

FactoryGirl.define do
  factory :restaurant do
    sequence(:name) { |n| "MyString#{n}" }
    sequence(:phone) { |n| "123456789#{n.to_s[-1]}" }
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
