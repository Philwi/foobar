# API-Response from surfline
# data => {
#   regionalForecast	{…}
#   subregions	[…]
#   spots	{
#     [
#       _id	"5af21bc9177e44001a8cc60b"
#       saveFailures	0
#       timezone	"America/Los_Angeles"
#       thumbnail	"https://spot-thumbnails.…default/default_1500.jpg"
#       rank	[…]
#       subregionId	"58581a836630e24c4487900b"
#       lat	34.012794079166625
#       lon	-118.50756
#       name	"Santa Monica Beach North"
#       tide	{…}
#       waterTemp	{…}
#       cameras	[…]
#       wind	{…}
#       weather	{…}
#       swells	[…]
#       legacyRegionId	2951
#       offshoreDirection	235
#       parentTaxonomy	[…]
#       legacyId	4886
#       abilityLevels	[]
#       boardTypes	[]
#       relivableRating	null
#       rating	{…}
#       surf	{…}
#       subregion	{…}
#       hasLiveWind	false
#       slug	"DEPRECATED"
#       conditions	{…}
#       waveHeight	{…}
#     ]
# }

require 'http'

module Surfline
  class Spots
    def initialize(http_client: Http)
      @http_client = http_client
      self.south = MIN_SOUTH
      self.west = MAX_WEST
      self.north = MAX_NORTH
      self.east = MIN_EAST
    end

    def fetch
      spots = spots_for_bounding_box
      create_new_surfline_spots(spots)
    end

    private

    MIN_SOUTH = -180
    MIN_EAST = -180
    MAX_NORTH = 180
    MAX_WEST = 180

    attr_accessor :south, :west, :north, :east
    attr_reader :http_client

    def spots_for_bounding_box
      result = http_client.get(url)
      data = result['data']
      return [] if data.blank?

      spots = data['spots']
      Rails.logger.info "Found #{spots.count} spots!"

      spots
    end

    def create_new_surfline_spots(spots)
      spots.each do |spot|
        next if spot_already_exists?(spot)

        surfline_spot =
          SurflineSpot.create(
            surfline_id: spot['_id'],
            lat: spot['lat'],
            lon: spot['lon'],
            name: spot['name']
          )

        Rails.logger.info "Surfline Spot: #{surfline_spot.inspect} created!"
      end
    end

    def spot_already_exists?(spot)
      SurflineSpot.find_by(surfline_id: spot['_id']).present?
    end

    def base_mapview_url
      'http://services.surfline.com/kbyg/mapview'
    end

    def url
      "#{base_mapview_url}?south=#{south}&west=#{west}&east=#{east}&north=#{north}"
    end
  end
end
