# == Schema Information
#
# Table name: surfline_conditions
#
#  id               :bigint           not null, primary key
#  forecast_day     :date
#  rating           :float
#  min_height       :float
#  max_height       :float
#  surfline_spot_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_surfline_conditions_on_surfline_spot_id  (surfline_spot_id)
#
require 'rails_helper'

RSpec.describe SurflineCondition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
