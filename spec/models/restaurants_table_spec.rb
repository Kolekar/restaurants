# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsTable, type: :model do
  let(:restaurants_table) { create(:restaurants_table) }
  describe 'Validations' do
    specify { expect(restaurants_table).to validate_presence_of(:name) }
    specify { expect(restaurants_table).to validate_presence_of(:restaurant) }
    specify { expect(restaurants_table).to validate_presence_of(:minimum) }
    specify { expect(restaurants_table).to validate_presence_of(:maximum) }
    specify { expect(restaurants_table).to validate_numericality_of(:minimum).only_integer }
    specify { expect(restaurants_table).to validate_numericality_of(:maximum).only_integer }
  end

  describe 'Associations' do
    specify { expect(restaurants_table).to belong_to(:restaurant) }
    specify { expect(restaurants_table).to have_many(:reservations) }
  end
end
