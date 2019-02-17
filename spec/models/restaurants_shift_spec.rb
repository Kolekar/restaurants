# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsShift, type: :model do
  let(:restaurant) { create(:restaurant) }
  let(:restaurants_shift) { create(:restaurants_shift) }
  describe 'Validations' do
    specify { expect(restaurants_shift).to validate_presence_of(:start_time) }
    specify { expect(restaurants_shift).to validate_presence_of(:end_time) }
    specify { expect(restaurants_shift).to validate_presence_of(:restaurant) }
    specify { expect(restaurants_shift).to validate_presence_of(:title) }
    context '#validate_end_time' do
      it 'returns error when end time less then start time' do
        restaurants_shift = build(:restaurants_shift, start_time: Time.now,
                                                      end_time: Time.now - 2.hour)
        expect(restaurants_shift.valid?).to eq false
      end

      it 'create when start time less then end time' do
        restaurants_shift = build(:restaurants_shift)
        expect(restaurants_shift.valid?).to eq true
      end
    end

    context '#validate_shift_overlaping' do
      it 'retuens an error when restaurant shift overlaps' do
        create(:restaurants_shift, restaurant: restaurant)
        restaurants_shift = build(:restaurants_shift, start_time: Time.now + 1.hour,
                                                      end_time: Time.now + 3.hour,
                                                      restaurant: restaurant)
        expect(restaurants_shift.valid?).to eq false
      end

      it 'create when restaurant shift ant overlaps' do
        create(:restaurants_shift, restaurant: restaurant)
        restaurants_shift = build(:restaurants_shift, start_time: Time.now + 3.hour,
                                                      end_time: Time.now + 4.hour,
                                                      restaurant: restaurant)
        expect(restaurants_shift.valid?).to eq true
      end
    end
  end

  describe 'Associations' do
    specify { expect(restaurants_shift).to belong_to(:restaurant) }
  end
end
