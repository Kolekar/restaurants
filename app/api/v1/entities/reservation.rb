# frozen_string_literal: true

module Api
  class V1::Entities::Reservation < Grape::Entity
    root 'reservations', 'reservation'

    expose :id, :reservation_time, :guest_count
    expose :guest, using: V1::Entities::Guest
  end
end
