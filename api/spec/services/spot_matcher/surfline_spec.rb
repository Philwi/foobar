# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpotMatcher::Surfline do
  context 'when no match found' do
    it 'creates a spot' do
      create(:surfline_spot)

      expect { described_class.new.merge_spots }.to change(Spot, :count).by 1
    end
  end

  context 'when match found' do
    it 'merges a spot' do
      lat = 50
      lon = 50
      surfline_spot = create(:surfline_spot, lat:, lon:)
      spot = create(:spot, lat:, lon:)

      expect { described_class.new.merge_spots }.to change(Spot, :count).by 0
      expect(surfline_spot.reload.spot.id).to be_equal spot.reload.id
    end
  end
end
