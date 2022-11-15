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
require 'rails_helper'

RSpec.describe SurflineSpot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
