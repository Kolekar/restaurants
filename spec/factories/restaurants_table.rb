# frozen_string_literal: true

FactoryGirl.define do
  factory :restaurants_table do
    name 'MyString'
    minimum 3
    maximum 6
    association :restaurant
  end
end
