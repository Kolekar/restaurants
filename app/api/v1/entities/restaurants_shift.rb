# frozen_string_literal: true

module Api
  class V1::Entities::RestaurantsShift < Grape::Entity
    root 'restaurants_shifts', 'restaurants_shift'

    expose :id, :title, :start_time, :end_time
  end
end
