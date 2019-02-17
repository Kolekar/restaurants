# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { create(:restaurant) }
  describe 'Validations' do
    specify { expect(restaurant).to validate_presence_of(:name) }
    specify { expect(restaurant).to validate_presence_of(:email) }
    specify { expect(restaurant).to validate_uniqueness_of(:email) }
    specify { expect(restaurant).to validate_presence_of(:phone) }
    specify { expect(restaurant).to validate_uniqueness_of(:phone).case_insensitive }
  end

  describe 'Associations' do
    specify { expect(restaurant).to have_many(:restaurants_tables) }
    specify { expect(restaurant).to have_many(:restaurants_shifts) }
  end
end
