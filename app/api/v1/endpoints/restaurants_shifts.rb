# frozen_string_literal: true

module Api
  module V1::Endpoints::RestaurantsShifts
    extend ActiveSupport::Concern

    included do
      namespace :restaurants_shifts, desc: '' do
        desc 'RestaurantsShift details',
             http_codes: {
               404 => 'restaurants_shift not found'
             }
        params do
          requires :id, type: String, desc: 'RestaurantsShift ID'
        end
        get ':id', entity: V1::Entities::RestaurantsShift do
          restaurants_shift = RestaurantsShift.find_by(id: params[:id])
          our_error!(404) if restaurants_shift.nil?
          present restaurants_shift, with: V1::Entities::RestaurantsShift
        end

        desc 'List of RestaurantsShifts', {
        }

        get '', entity: V1::Entities::RestaurantsShift do
          restaurants_shifts = RestaurantsShift.all
          present restaurants_shifts, with: V1::Entities::RestaurantsShift
        end

        desc 'Restaurents RestaurantsShift',
             requires_api_user: true
        params do
          requires :title, type: String, desc: 'RestaurantsShift title'
          requires :end_time, type: String, desc: 'RestaurantsShift end_time'
          requires :start_time, type: String, desc: 'RestaurantsShift start_time'
        end
        post '', entity: V1::Entities::RestaurantsShift do
          restaurants_shift = RestaurantsShift.new
          restaurants_shift.title = params[:title]
          restaurants_shift.end_time = Time.parse(params[:end_time])
          restaurants_shift.start_time = Time.parse(params[:start_time])
          if restaurants_shift.save
            present restaurants_shift, with: V1::Entities::RestaurantsShift
          else
            error!({ error: restaurants_shift.errors.full_messages.join(', ') }, 400)
          end
        end

        desc 'Update Restaurents RestaurantsShift',
             requires_api_user: true
        params do
          requires :id, type: String, desc: 'RestaurantsShift ID'
          requires :title, type: String, desc: 'RestaurantsShift title'
          requires :start_time, type: String, desc: 'RestaurantsShift start_time'
          requires :end_time, type: String, desc: 'RestaurantsShift end_time'
        end
        put ':id', entity: V1::Entities::RestaurantsShift do
          restaurants_shift = RestaurantsShift.find_by(id: params[:id])
          our_error!(404) if restaurants_shift.nil?
          restaurants_shift.title = params[:title]
          restaurants_shift.start_time = Time.parse(params[:start_time])
          restaurants_shift.end_time = Time.parse(params[:end_time])
          if restaurants_shift.save
            present restaurants_shift, with: V1::Entities::RestaurantsShift
          else
            error!({ error: restaurants_shift.errors.full_messages.join(', ') }, 400)
          end
        end
      end
    end # of included do
  end
end
