# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:restaurant) { create(:restaurant) }
  let!(:restaurants_shift) { create(:restaurants_shift, restaurant: restaurant) }
  let(:restaurants_table) { create(:restaurants_table, restaurant: restaurant) }
  let(:reservation) { create(:reservation, restaurants_table: restaurants_table) }
  describe 'Validations' do
    specify { expect(reservation).to validate_presence_of(:guest) }
    specify { expect(reservation).to validate_presence_of(:restaurants_table) }
    specify { expect(reservation).to validate_presence_of(:reservation_time) }
    specify { expect(reservation).to validate_presence_of(:guest_count) }

    context '#validate_guest_count' do
      it 'returns error when guest_count is less than table minimum guest' do
        reservation = build(:reservation, restaurants_table: restaurants_table, guest_count: 2)
        expect(reservation.valid?).to eq false
      end

      it 'returns error when guest_count is gretor than table maximum guest' do
        reservation = build(:reservation, restaurants_table: restaurants_table, guest_count: 8)
        expect(reservation.valid?).to eq false
      end

      it 'create reservation' do
        reservation = build(:reservation, restaurants_table: restaurants_table, guest_count: 4)
        expect(reservation.valid?).to eq true
      end
    end

    context '#validate_reservation_time' do
      it 'retuns an error when reservation_time is not belongs to restaurant shift' do
        reservation = build(:reservation, restaurants_table: restaurants_table, reservation_time: Time.now + 4.hour)
        expect(reservation.valid?).to eq false
      end
      it 'retuns an error when reservation_time is not belongs to restaurant shift' do
        reservation = build(:reservation, restaurants_table: restaurants_table, reservation_time: Time.now + 1.hour)
        expect(reservation.valid?).to eq true
      end
    end

    context '#validate_past_date_reservation' do
      it 'retuns an error when reservation_time is past' do
        reservation = build(:reservation, restaurants_table: restaurants_table, reservation_time: Time.now - 1.hour)
        expect(reservation.valid?).to eq false
      end

      it 'create reservation' do
        reservation = build(:reservation, restaurants_table: restaurants_table, reservation_time: Time.now + 1.hour)
        expect(reservation.valid?).to eq true
      end
    end
  end

  describe 'Associations' do
    specify { expect(reservation).to have_one(:restaurant).through(:restaurants_table) }
    specify { expect(reservation).to belong_to(:restaurants_table) }
    specify { expect(reservation).to belong_to(:guest) }
  end
end
