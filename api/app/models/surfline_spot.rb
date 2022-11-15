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
class SurflineSpot < ApplicationRecord
  belongs_to :spot, optional: true
  has_many :surfline_conditions

  scope :not_merged_spots, -> { where(spot_id: nil) }

  geocoded_by :surfline_spots, latitude: :lat, longitude: :lon
end
