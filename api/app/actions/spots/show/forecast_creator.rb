module Spots
  class Show
    class ForecastCreator
      def initialize(city:, km_radius:)
        @city = city
        @km_radius = km_radius
      end

      def call
        result = spots
        create_forecast
        result
      end

      private

      attr_reader :city, :km_radius

      def create_forecast
        ::Surfline::Conditions.new.create_for_spots(spots:)
      end

      def spots
        Spot.near(city, km_radius)
      end
    end
  end
end
