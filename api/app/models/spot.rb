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
class Spot < ApplicationRecord
  extend FriendlyId
  friendly_id :name

  geocoded_by :spots, latitude: :lat, longitude: :lon

  has_one :surfline_spot

  scope :ordered, -> { order(:sort_order, :id) }
end
