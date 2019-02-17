
class Guest < ApplicationRecord
  has_many :reservations, inverse_of: :guest

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
