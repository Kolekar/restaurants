# frozen_string_literal: true

require 'rails_helper'

describe 'Reservations', type: :request do
  let(:guest) { create(:guest) }
  let(:restaurant) { create(:restaurant) }
  let!(:restaurants_shift) { create(:restaurants_shift, restaurant: restaurant) }
  let(:restaurants_table) { create(:restaurants_table, restaurant: restaurant) }
  let(:reservation) { create(:reservation, restaurants_table: restaurants_table) }
  let(:params) do
    { reservation_time: Time.now.tomorrow + 1.hour, guest_count: 4,
      restaurants_table_id: restaurants_table.id, guest_id: guest.id }
  end
  describe 'GET /api/v1/reservations' do
    it 'succeeds ' do
      reservation
      get '/api/v1/reservations'
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['reservations'].length).to eq 1
    end
  end

  describe 'GET /api/v1/reservations/:id' do
    it 'succeeds ' do
      get "/api/v1/reservations/#{reservation.id}"
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['reservation']['id']).to eq reservation.id
    end
  end

  describe 'POST /api/v1/reservations' do
    it 'succeeds ' do
      post '/api/v1/reservations', params: params
      expect(response.code).to eq '201'
      expect(JSON.parse(response.body)['reservation']['guest_count']).to eq 4
    end
  end

  describe 'PUT /api/v1/reservations/:id' do
    it 'succeeds ' do
      put "/api/v1/reservations/#{reservation.id}", params: params
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['reservation']['guest_count']).to eq 4
    end
  end
end
