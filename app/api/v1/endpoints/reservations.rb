# frozen_string_literal: true

module Api
  module V1::Endpoints::Reservations
    extend ActiveSupport::Concern

    included do
      namespace :reservations, desc: '' do
        desc 'Reservation details',
             http_codes: {
               404 => 'reservation not found'
             }
        params do
          requires :id, type: Integer, desc: 'Reservation ID'
        end
        get ':id', entity: V1::Entities::Reservation do
          reservation = Reservation.find_by(id: params[:id])
          our_error!(404) if reservation.nil?
          present reservation, with: V1::Entities::Reservation
        end

        desc 'List of Reservations', {
        }

        get '', entity: V1::Entities::Reservation do
          reservations = Reservation.all
          present reservations, with: V1::Entities::Reservation
        end

        desc 'Restaurents Reservation', {
        }
        params do
          requires :reservation_time, type: String, desc: 'Reservation Time'
          requires :guest_count, type: Integer, desc: 'Reservation guest_count'
          requires :restaurants_table_id, type: String, desc: 'Reservation restaurants_table_id'
          requires :guest_id, type: String, desc: 'Reservation guest_id'
        end
        post '', entity: V1::Entities::Reservation do
          reservation = Reservation.new
          reservation.reservation_time = Time.parse(params[:reservation_time])
          reservation.guest_count = params[:guest_count]
          reservation.restaurants_table_id = params[:restaurants_table_id]
          reservation.guest_id = params[:guest_id]
          if reservation.save
            present reservation, with: V1::Entities::Reservation
          else
            error!({ error: reservation.errors.full_messages.join(', ') }, 400)
          end
        end

        desc 'Update Restaurents Reservation',
             requires_api_user: true
        params do
          requires :id, type: String, desc: 'Reservation ID'
          requires :reservation_time, type: String, desc: 'Reservation Time'
          requires :guest_count, type: String, desc: 'Reservation guest_count'
          requires :restaurants_table_id, type: String, desc: 'Reservation restaurants_table_id'
          requires :guest_id, type: String, desc: 'Reservation guest_id'
        end
        put ':id', entity: V1::Entities::Reservation do
          reservation = Reservation.find_by(id: params[:id])
          our_error!(404) if reservation.nil?
          reservation.reservation_time = Time.parse(params[:reservation_time])
          reservation.guest_count = params[:guest_count]
          reservation.restaurants_table_id = params[:restaurants_table_id]
          reservation.guest_id = params[:guest_id]
          if reservation.save
            present reservation, with: V1::Entities::Reservation
          else
            error!({ error: reservation.errors.full_messages.join(', ') }, 400)
          end
        end
      end
    end # of included do
  end
end
