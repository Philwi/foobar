
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Surfline::Spots do
  context 'when fetching data from api' do
    it 'creates spots' do
      surfline_spots = described_class.new(http_client: FakeHTTPClient)
      expect { surfline_spots.fetch }.to change(SurflineSpot, :count).by 1
    end
  end
end

module FakeHTTPClient
  class << self
    def get(_url)
      {
        'data' => {
          'spots' =>
          [
            '_id' =>	'5af21bc9177e44001a8cc60b',
            'saveFailures' =>	0,
            'timezone' =>	'America/Los_Angeles',
            'thumbnail' =>	'https://spot-thumbnails.…default/default_1500.jpg',
            'subregionId' =>	'58581a836630e24c4487900b',
            'lat' =>	34.012794079166625,
            'lon' =>	-118.50756,
            'name' =>	'Santa Monica Beach North',
            'legacyRegionId' =>	2951,
            'offshoreDirection' => 235,
            'legacyId' =>	4886,
            'hasLiveWind' =>	false,
            'slug' =>	'DEPRECATED'
          ]
        }
      }
    end
  end
end
