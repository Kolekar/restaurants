class Reservation < ApplicationRecord
  belongs_to :guest, inverse_of: :reservations
  belongs_to :restaurants_table, inverse_of: :reservations
  has_one :restaurant, through: :restaurants_table
  delegate :restaurants_shifts, to: :restaurant, allow_nil: true

  validate :validate_guest_count, :validate_past_date_reservation,
           :validate_reservation_time
  validates :guest, :restaurants_table, :reservation_time, presence: true
  validates :guest_count, presence: true, numericality: { only_integer: true }

  before_create :reservation_mail
  before_update :reservation_update_mail

  def validate_guest_count
    return if restaurants_table.nil? || restaurants_table.try(:minimum).nil? ||
              restaurants_table.try(:maximum).nil? || guest_count.nil?
    return if guest_count >= restaurants_table.try(:minimum) &&
              guest_count <= restaurants_table.try(:maximum)

    errors.add(:guest_count, "#{restaurants_table.name} \
      requires minimum guest count is \
      #{restaurants_table.minimum} and maximum \
      guest count is #{restaurants_table.maximum}")
  end

  def validate_reservation_time
    return if restaurants_shifts.nil? || reservation_time.nil?
    return if restaurants_shifts.find_shift(reservation_time).first

    errors.add(:reservation_time, 'reservation_time must be between reservations shift')
  end

  def validate_past_date_reservation
    return if reservation_time && Time.now < reservation_time

    errors.add(:reservation_time, 'reservation_time must be future')
  end

  def reservation_mail; end

  def reservation_update_mail; end
end
