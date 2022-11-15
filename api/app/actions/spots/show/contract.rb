module Spots
  class Show
    class Contract < Dry::Validation::Contract
      params do
        required(:date).value(:date)
        required(:city).filled(:string)
        required(:level).filled(:string)
        required(:km_radius).filled(:integer)
      end
    end
  end
end
