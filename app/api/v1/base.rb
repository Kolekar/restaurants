# frozen_string_literal: true

require 'grape-swagger'
module Api
  class V1::Base < Grape::API
    prefix 'api'
    format :json
    default_format :json
    version 'v1', using: :path

    include V1::Endpoints::Reservations
    include V1::Endpoints::Guests
    include V1::Endpoints::Restaurants
    include V1::Endpoints::RestaurantsShifts
    include V1::Endpoints::RestaurantsTables

    add_swagger_documentation(
      hide_format: true,
      api_version: version,
      hide_documentation_path: true
    )
  end
end
