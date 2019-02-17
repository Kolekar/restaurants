# frozen_string_literal: true

module Api
  class V1::Entities::Restaurant < Grape::Entity
    root 'restaurants', 'restaurant'

    expose :id, :name, :email
    expose :reservations, using: V1::Entities::Reservation
  end
end
