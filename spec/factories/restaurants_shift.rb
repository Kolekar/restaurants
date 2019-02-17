# frozen_string_literal: true

FactoryGirl.define do
  factory :restaurants_shift do
    title 'MyString'
    start_time Time.now
    end_time Time.now + 2.hour
    association :restaurant
  end
end
