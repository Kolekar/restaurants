# frozen_string_literal: true

module Api
  module V1::Endpoints::RestaurantsTables
    extend ActiveSupport::Concern

    included do
      namespace :restaurants_tables, desc: '' do
        desc 'RestaurantsTable details',
             http_codes: {
               404 => 'restaurants_table not found'
             }
        params do
          requires :id, type: String, desc: 'RestaurantsTable ID'
        end
        get ':id', entity: V1::Entities::RestaurantsTable do
          restaurants_table = RestaurantsTable.find_by(id: params[:id])
          our_error!(404) if restaurants_table.nil?
          present restaurants_table, with: V1::Entities::RestaurantsTable
        end

        desc 'List of RestaurantsTables', {
        }

        get '', entity: V1::Entities::RestaurantsTable do
          restaurants_tables = RestaurantsTable.all
          present restaurants_tables, with: V1::Entities::RestaurantsTable
        end

        desc 'Restaurents RestaurantsTable',
             requires_api_user: true
        params do
          requires :name, type: String, desc: 'RestaurantsTable name'
          requires :minimum, type: Integer, desc: 'RestaurantsTable minimum'
          requires :maximum, type: Integer, desc: 'RestaurantsTable maximum'
          requires :restaurant_id, type: Integer, desc: 'Restaurant Id'
        end
        post '', entity: V1::Entities::RestaurantsTable do
          restaurant = Restaurant.find_by(id: params[:id])
          our_error!(404) if restaurant.nil?
          restaurants_table = RestaurantsTable.new
          restaurants_table.name = params[:name]
          restaurants_table.minimum = params[:minimum]
          restaurants_table.maximum = params[:maximum]
          restaurants_table.restaurant = restaurant
          if restaurants_table.save
            present restaurants_table, with: V1::Entities::RestaurantsTable
          else
            error!({ error: restaurants_table.errors.full_messages.join(', ') }, 400)
          end
        end

        desc 'Update Restaurents RestaurantsTable',
             requires_api_user: true
        params do
          requires :id, type: String, desc: 'RestaurantsTable ID'
          requires :name, type: String, desc: 'RestaurantsTable name'
          requires :email, type: String, desc: 'RestaurantsTable email'
        end
        put '', entity: V1::Entities::RestaurantsTable do
          restaurants_table = RestaurantsTable.find_by(id: params[:id])
          our_error!(404) if restaurants_table.nil?
          restaurant = Restaurant.find_by(id: params[:id])
          our_error!(404) if restaurant.nil?
          restaurants_table = RestaurantsTable.new
          restaurants_table.name = params[:name]
          restaurants_table.minimum = params[:minimum]
          restaurants_table.maximum = params[:maximum]
          restaurants_table.restaurant = restaurant
          if restaurants_table.save
            present restaurants_table, with: V1::Entities::RestaurantsTable
          else
            error!({ error: restaurants_table.errors.full_messages.join(', ') }, 400)
          end
        end
      end
    end
  end
end
