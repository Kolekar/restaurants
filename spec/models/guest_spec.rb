# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guest, type: :model do
  let(:guest) { create(:guest) }
  describe 'Validations' do
    specify { expect(guest).to validate_presence_of(:name) }
    specify { expect(guest).to validate_presence_of(:email) }
    specify { expect(guest).to validate_uniqueness_of(:email) }
  end

  describe 'Associations' do
    specify { expect(guest).to have_many(:reservations) }
  end
end
