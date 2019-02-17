# frozen_string_literal: true

class RestaurantsShift < ApplicationRecord
  belongs_to :restaurant, inverse_of: :restaurants_shifts

  validates :start_time, :end_time, :restaurant, :title, presence: true
  validate :validate_end_time, :validate_shift_overlaping

  scope :overlap_shifts, lambda { |start_time, end_time, restaurant_id|
                           where("restaurants_shifts.restaurant_id = ? AND\
                           restaurants_shifts.start_time < ? AND \
                           ? < restaurants_shifts.end_time",
                                 restaurant_id, end_time, start_time)
                         }
  scope :find_shift, lambda { |reservation_time|
                       where("restaurants_shifts.start_time <= ? AND \
                         restaurants_shifts.end_time >= ?",
                             reservation_time, reservation_time)
                     }

  def validate_end_time
    errors.add(:end_time, 'should be greater than starts at') if end_time? && start_time? && end_time <= start_time
  end

  def validate_shift_overlaping
    return unless start_time? && end_time? && restaurant.present?

    overlap_shift = RestaurantsShift.overlap_shifts(start_time, end_time, restaurant_id).first
    return if overlap_shift.blank?

    errors.add(
      :overlapping,
      "with '#{overlap_shift.title}' scheduled" \
        " from #{overlap_shift.start_time}" \
        " to #{overlap_shift.end_time}." \
        ' Please select a different time period.'
    )
  end
end
