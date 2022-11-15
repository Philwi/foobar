# frozen_string_literal: true

module SpotMatcher
  class Surfline
    def initialize
      @surfline_spots = ::SurflineSpot.not_merged_spots
    end

    def merge_spots
      surfline_spots.each do |surfline_spot|
        if matching_spot?(surfline_spot)
          merge_spot(surfline_spot)
          next
        end

        add_spot(surfline_spot)
      end
    end

    private

    attr_reader :surfline_spots

    def matching_spot?(surfline_spot)
      matching_spot(surfline_spot).present?
    end

    def matching_spot(surfline_spot)
      ::Spot.near([surfline_spot.lat, surfline_spot.lon], 0.01).first
    end

    def merge_spot(surfline_spot)
      spot = matching_spot(surfline_spot)
      spot.update(surfline_v2_id: surfline_spot.surfline_id) if spot.surfline_v2_id.blank?
      surfline_spot.update(spot:)
    end

    def add_spot(surfline_spot)
      spot = Spot.create(
        name: surfline_spot.name,
        lat: surfline_spot.lat,
        lon: surfline_spot.lon,
        surfline_v2_id: surfline_spot.surfline_id
      )

      surfline_spot.update(spot:)
    end
  end
end
