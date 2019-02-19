# frozen_string_literal: true

class Restaurant < ApplicationRecord
  has_many :restaurants_tables, inverse_of: :restaurant
  has_many :restaurants_shifts, inverse_of: :restaurant
  has_many :reservations, through: :restaurants_tables

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :phone, presence: true, numericality: { only_integer: true },
                    uniqueness: { case_sensitive: false }, length: { is: 10 }
end
