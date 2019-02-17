# frozen_string_literal: true

FactoryGirl.define do
  factory :reservation do
    reservation_time Time.now + 2.hour
    guest_count 3
    association :restaurants_table
    association :guest
  end
end
