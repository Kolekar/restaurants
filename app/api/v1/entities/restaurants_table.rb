# frozen_string_literal: true

module Api
  class V1::Entities::RestaurantsTable < Grape::Entity
    root 'restaurants_tables', 'restaurants_table'

    expose :id, :name, :minimum, :maximum
  end
end
