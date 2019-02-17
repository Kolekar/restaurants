# frozen_string_literal: true

# require 'grape_logging'

module Api
  class Base < Grape::API
    
    mount Api::V1::Base
  end
end
