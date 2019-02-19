# frozen_string_literal: true

require 'rails_helper'

describe 'Restaurent', type: :request do
  let(:restaurant) { create(:restaurant) }
  let!(:restaurants_shift) { create(:restaurants_shift, restaurant: restaurant) }
  let(:restaurants_table) { create(:restaurants_table, restaurant: restaurant) }
  let(:reservation) { create(:reservation, restaurants_table: restaurants_table) }
  let(:params) { { name: 'Test', phone: '1234567890', email: 'test@test.com' } }
  describe 'GET /api/v1/restaurants' do
    it 'succeeds ' do
      restaurant
      get '/api/v1/restaurants'
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['restaurants'].length).to eq 1
    end
  end

  describe 'GET /api/v1/restaurants/:id' do
    it 'succeeds ' do
      reservation
      get "/api/v1/restaurants/#{restaurant.id}"
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['restaurant']['id']).to eq restaurant.id
      expect(JSON.parse(response.body)['restaurant']['reservations'].length).to eq 1
    end
  end

  describe 'POST /api/v1/restaurants' do
    it 'succeeds ' do
      post '/api/v1/restaurants', params: params
      expect(response.code).to eq '201'
      expect(JSON.parse(response.body)['restaurant']['email']).to eq 'test@test.com'
    end
  end

  describe 'PUT /api/v1/restaurants/:id' do
    it 'succeeds ' do
      put "/api/v1/restaurants/#{restaurant.id}", params: params
      expect(response.code).to eq '200'
      expect(JSON.parse(response.body)['restaurant']['email']).to eq 'test@test.com'
    end

    it 'error when email is not valid ' do
      params[:email] = 'xyz'
      put "/api/v1/restaurants/#{restaurant.id}", params: params
      expect(response.code).to eq '400'
    end

    it 'error when phone is not valid ' do
      params[:phone] = 'xyz'
      put "/api/v1/restaurants/#{restaurant.id}", params: params
      expect(response.code).to eq '400'
    end
  end
end
