# frozen_string_literal: true

module Api
  class V1::Entities::Guest < Grape::Entity
    root 'guests', 'guest'

    expose :id, :name, :email
  end
end
