FactoryBot.define do
  factory :surfline_condition do
    forecast_day { Time.zone.today }
    rating { rand(5) }
    min_height { rand(0.1..5.0) }
    max_height { rand(0.1..5.0) }
    surfline_spot_id { create(:surfline_spots).id }
  end
end
