# frozen_string_literal: true

require 'grape_logging'

module Api
  class Base < Grape::API
    use GrapeLogging::Middleware::RequestLogger,
        instrumentation_key: 'grape.request',
        include: [GrapeLogging::Loggers::UserEnv.new,
                  GrapeLogging::Loggers::FilterParameters.new,
                  GrapeLogging::Loggers::ClientEnv.new,
                  GrapeLogging::Loggers::Response.new]
    mount Api::V1::Base
  end
end
