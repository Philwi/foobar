require 'dry/monads'

module Spots
  class Show
    include Dry::Monads[:result, :do]

    def initialize(params)
      @params = parse(params)
    end

    def call
      result = yield validate_params
      result = yield clear_old_forecasts(result)
      result = yield create_forecast(result)
      result = yield get_forecast_for_spots(result)
      prepare_response(result)
    end

    private

    attr_reader :params

    def parse(params)
      spot = params['spot']
      return JSON.parse(spot) if spot.is_a? String

      spot
    end

    def validate_params
      result = ::Spots::Show::Contract.new.call(params)
      return Success(result) if result.success?

      Failure(result.errors)
    end

    def clear_old_forecasts(input)
      Surfline::Conditions.delete_old
      Success(input)
    end

    def create_forecast(input)
      city = input['city']
      km_radius = input['km_radius']

      result = ::Spots::Show::ForecastCreator.new(city:, km_radius:).call
      Success({ contract: input, spots: result })
    end

    def get_forecast_for_spots(input)
      city = input[:contract][:city]
      level = input[:contract][:level]
      date = input[:contract][:date]
      km_radius = input[:contract][:km_radius]
      spots = ::Spots::Show::SpotFinder.new(city:, level:, date:, km_radius:).call

      return Failure({ errors: { messages: ['No spots found.'] ,status: 404 }}) if spots.blank?

      Success(input.merge({ kook_spots: spots }))
    end

    def prepare_response(input)
      Success({ status: 200, spots: input[:kook_spots].to_json })
    end
  end
end
