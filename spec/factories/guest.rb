# frozen_string_literal: true

FactoryGirl.define do
  factory :guest do
    name 'MyString'
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
