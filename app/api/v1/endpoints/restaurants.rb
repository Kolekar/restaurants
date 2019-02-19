# frozen_string_literal: true

module Api
  module V1::Endpoints::Restaurants
    extend ActiveSupport::Concern

    included do
      namespace :restaurants, desc: '' do
        desc 'Restaurant details',
             http_codes: {
               404 => 'restaurant not found'
             }
        params do
          requires :id, type: String, desc: 'Restaurant ID'
        end
        get ':id', entity: V1::Entities::Restaurant do
          restaurant = Restaurant.find_by(id: params[:id])
          our_error!(404) if restaurant.nil?
          present restaurant, with: V1::Entities::Restaurant
        end

        desc 'List of Restaurants', {
        }

        get '', entity: V1::Entities::Restaurant do
          restaurants = Restaurant.all.includes(restaurants_tables: :reservations)
          present restaurants, with: V1::Entities::Restaurant
        end

        desc 'Restaurents Restaurant',
             requires_api_user: true
        params do
          requires :email, type: String, desc: 'Restaurant email'
          requires :phone, type: String, desc: 'Restaurant phone'
          requires :email, type: String, desc: 'Restaurant email'
        end
        post '', entity: V1::Entities::Restaurant do
          restaurant = Restaurant.new
          restaurant.name = params[:name]
          restaurant.email = params[:email]
          restaurant.phone = params[:phone]
          if restaurant.save
            present restaurant, with: V1::Entities::Restaurant
          else
            error!({ error: restaurant.errors.full_messages.join(', ') }, 400)
          end
        end

        desc 'Update Restaurents Restaurant',
             requires_api_user: true
        params do
          requires :id, type: String, desc: 'Restaurant ID'
          requires :name, type: String, desc: 'Restaurant name'
          requires :phone, type: String, desc: 'Restaurant phone'
          requires :email, type: String, desc: 'Restaurant email'
        end
        put ':id', entity: V1::Entities::Restaurant do
          restaurant = Restaurant.find_by(id: params[:id])
          our_error!(404) if restaurant.nil?
          restaurant.email = params[:email]
          restaurant.name = params[:name]
          restaurant.phone = params[:phone]

          if restaurant.save
            present restaurant, with: V1::Entities::Restaurant
          else
            error!({ error: restaurant.errors.full_messages.join(', ') }, 400)
          end
        end
      end
    end # of included do
  end
end
