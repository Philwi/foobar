# frozen_string_literal: true

class SpotLocator
  def initialize(lat:, lon:, spots: Spot.all)
    @lat = lat
    @lon = lon
    @spots = spots
  end

  def find_nearby_spots(km_radius: 50)
    spots.near([lat, lon], km_radius)
  end

  private

  attr_reader :lat, :lon, :spots
end
