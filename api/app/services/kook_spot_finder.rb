# frozen_string_literal: true

class KookSpotFinder
  def initialize(level:, forecast_service: SurflineCondition, km_radius: 50)
    raise StandardError.new, 'Unknown Ability Level!' unless ABILITY_LEVELS.include?(level)

    @level = level
    @forecast_service = forecast_service
    @km_radius = km_radius
  end

  def get_nearby_spots_for_today(lat:, lon:)
    get_nearby_spots_for_date(lat:, lon:, date: Time.zone.today)
  end

  def get_nearby_spots_for_tomorrow(lat:, lon:)
    get_nearby_spots_for_date(lat:, lon:, date: Time.zone.tomorrow)
  end

  def get_nearby_spots_for_date(lat:, lon:, date:)
    spots = SpotLocator.new(lat:, lon:).find_nearby_spots(km_radius:)
    spots_according_to_ability_and_date(spots:, date:)
  end

  private

  attr_reader :level, :forecast_service, :km_radius

  ABILITY_LEVELS = %w[kook intermediate].freeze

  GOOD_CONDITIONS = {
    kook: {
      min_wave_height: 0.4,
      max_wave_height: 0.9
    },
    intermediate: {
      min_wave_height: 0.5,
      max_wave_height: 1.9
    }
  }.with_indifferent_access.freeze

  def spots_according_to_ability_and_date(spots:, date:)
    spots.select do |spot|
      surfline_spot = spot.surfline_spot
      next if surfline_spot.blank?

      forecast =
        forecast_service.where(
          'surfline_spot_id = ? AND forecast_day = ?', surfline_spot.id, date
        ).last

      next if forecast.blank?

      forecast.min_height >= condition_for_given_level[:min_wave_height] &&
        forecast.max_height <= condition_for_given_level[:max_wave_height]
    end
  end

  def condition_for_given_level
    GOOD_CONDITIONS[level]
  end
end
