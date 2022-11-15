module Spots
  class Show
    class SpotFinder
      def initialize(city:, level:, date:, km_radius:)
        @city = city
        @level = level
        @date = date
        @km_radius = km_radius
      end

      def call
        spot_finder.get_nearby_spots_for_date(lat:, lon:, date:)
      end

      private

      def spot_finder
        KookSpotFinder.new(level:, km_radius:)
      end

      def location
        @location ||= Geocoder.search(city).first.data
      end

      def lat
        location['lat']
      end

      def lon
        location['lon']
      end

      attr_reader :city, :level, :date, :km_radius
    end
  end
end
