# frozen_string_literal: true

# == Schema Information
#
# Table name: spots
#
#  id             :integer          not null, primary key
#  name           :string
#  lat            :float
#  lon            :float
#  surfline_v1_id :integer
#  msw_id         :integer
#  spitcast_id    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  subregion_id   :bigint
#  spitcast_slug  :string
#  sort_order     :integer
#  surfline_v2_id :string
#
# Indexes
#
#  index_spots_on_subregion_id_and_slug        (subregion_id,slug) UNIQUE
#  index_spots_on_subregion_id_and_sort_order  (subregion_id,sort_order) UNIQUE
#  spots_unique_index                          (msw_id,surfline_v1_id,surfline_v2_id,spitcast_id) UNIQUE
#
FactoryBot.define do
  factory :spot do
    lat { rand(180) }
    lon { rand(180) }
    name { Faker::Name.name }
  end
end
