# frozen_string_literal: true

require 'http'

module Surfline
  class Conditions
    def initialize(http_client: ::Http)
      @http_client = http_client
    end

    def save_for(surfline_id:, days: 5)
      result = http_client.get(url(surfline_id:, days:))
      conditions = result.dig('data', 'conditions')
      return Rails.logger.info "No conditions for spot: #{surfline_id}" if conditions.blank?

      create_conditions(conditions:, surfline_id:)
    end

    def create_for_all_spots(days: 5)
      spots = Spot.where.not(surfline_v2_id: nil)
      create_for_spots(spots:, days:)
    end

    def create_for_spots(spots:, days: 5)
      spots.each do |spot|
        next if condition_already_created?(spot:)

        save_for(surfline_id: spot.surfline_v2_id, days:)
      end
    end

    def self.delete_old
      SurflineCondition.where('created_at < ?', Time.zone.today).delete_all
    end

    private

    attr_reader :http_client

    def url(surfline_id:, days:)
      "http://services.surfline.com/kbyg/spots/forecasts/conditions?spotId=#{surfline_id}&days=#{days}"
    end

    def create_conditions(conditions:, surfline_id:)
      conditions.each do |condition|
        SurflineCondition.create(
          min_height: min_height(condition),
          max_height: max_height(condition),
          surfline_spot_id: SurflineSpot.find_by(surfline_id:).id,
          forecast_day: condition['forecastDay']
        )
      end
    end

    def condition_already_created?(spot:)
      surfline_spot_id = SurflineSpot.find_by(surfline_id: spot.surfline_v2_id)&.id
      return false if surfline_spot_id.blank?

      SurflineCondition.find_by(surfline_spot_id:).present?
    end

    def max_height(condition)
      (condition['am']['maxHeight'] + condition['pm']['maxHeight']) / 2
    end

    def min_height(condition)
      (condition['am']['minHeight'] + condition['pm']['minHeight']) / 2
    end
  end
end
