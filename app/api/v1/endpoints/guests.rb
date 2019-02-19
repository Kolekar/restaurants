# frozen_string_literal: true

module Api
  module V1::Endpoints::Guests
    extend ActiveSupport::Concern

    included do
      namespace :guests, desc: '' do
        desc 'Guest details',
             http_codes: {
               404 => 'guest not found'
             }
        params do
          requires :id, type: Integer, desc: 'Guest ID'
        end
        get ':id', entity: V1::Entities::Guest do
          guest = Guest.find_by(id: params[:id])
          our_error!(404) if guest.nil?
          present guest, with: V1::Entities::Guest
        end

        desc 'List of Guests', {
        }

        get '', entity: V1::Entities::Guest do
          guests = Guest.all
          present guests, with: V1::Entities::Guest
        end

        desc 'Restaurents Guest', {
        }
        params do
          requires :name, type: String, desc: 'Guest name'
          requires :email, type: String, desc: 'Guest email'
        end
        post '', entity: V1::Entities::Guest do
          guest = Guest.new
          guest.name = params[:name]
          guest.email = params[:email]
          if guest.save
            present guest, with: V1::Entities::Guest
          else
            error!({ error: guest.errors.full_messages.join(', ') }, 400)
          end
        end

        desc 'Update Restaurents Guest',
             requires_api_user: true
        params do
          requires :id, type: Integer, desc: 'Guest ID'
          requires :name, type: String, desc: 'Guest name'
          requires :email, type: String, desc: 'Guest email'
        end
        put ':id', entity: V1::Entities::Guest do
          guest = Guest.find_by(id: params[:id])
          our_error!(404) if guest.nil?
          guest.name = params[:name]
          guest.email = params[:email]
          if guest.save
            present guest, with: V1::Entities::Guest
          else
            error!({ error: guest.errors.full_messages.join(', ') }, 400)
          end
        end
      end
    end
  end
end
