module SpotMatcher
  class Base
    def merge_spots
      NoMethodError.new 'Abstract Method! Define it in concrete class!'
    end

    private

    def matching_spots
      # TODO: Geocoder stuff for distance
    end
  end
end
