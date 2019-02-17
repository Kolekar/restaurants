# frozen_string_literal: true

class RestaurantsTable < ApplicationRecord
  belongs_to :restaurant, inverse_of: :restaurants_tables
  has_many :reservations, inverse_of: :restaurants_table

  validates :name, :minimum, :restaurant, :maximum, presence: true
  validates :minimum, :maximum, numericality: { only_integer: true }
end
