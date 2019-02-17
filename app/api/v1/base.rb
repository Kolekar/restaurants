# frozen_string_literal: true

module Api
  class V1::Base < Grape::API
    prefix 'api'
    format :json
    default_format :json
    version 'v1', using: :path

    include V4::Extensions::Grape # must be first

    before do
      header 'X-Api-Version', '4.2.6'
      header 'P3P', "CP='This is no policy'"
      # Enable once this version is retired:
      # header 'X-Api-Expires-On', '2014-10-26T00:00:00Z'
    end

    include V4::Endpoints::Partner::Reservations
    mount V4::Endpoints::CreditCards

    add_swagger_documentation(
      hide_format: true,
      api_version: version,
      hide_documentation_path: true,
      markdown: GrapeSwagger::Markdown::KramdownAdapter.new
    )
  end
end
