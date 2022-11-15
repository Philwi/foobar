# frozen_string_literal: true

# == Schema Information
#
# Table name: surfline_spots
#
#  id          :bigint           not null, primary key
#  spot_id     :bigint
#  lat         :float
#  lon         :float
#  name        :string
#  surfline_id :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_surfline_spots_on_spot_id      (spot_id)
#  index_surfline_spots_on_surfline_id  (surfline_id) UNIQUE
#
FactoryBot.define do
  factory :surfline_spot do
    lat { rand(180) }
    lon { rand(180) }
    name { Faker::Name.name }
    spot_id { create(:spot).id }
    surfline_id { SecureRandom.uuid }
  end
end
