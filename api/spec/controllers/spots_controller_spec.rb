# frozen_string_literal: true

require 'rails_helper'

describe SpotsController, type: :request do
  let(:forecast_url) { '/forecast' }

  context 'when valid request' do
    before do
      lat = 41.1494512
      lon = -8.6107884

      spot1 = create(:spot, lat:, lon:)
      spot2 = create(:spot, lat: (lat + 1), lon:)
      surfline_spot1 = create(:surfline_spot, lat:, lon:, spot_id: spot1.id)
      surfline_spot2 = create(:surfline_spot, lat:, lon:, spot_id: spot2.id)
      create(:surfline_condition, surfline_spot_id: surfline_spot1.id, min_height: 0.5, max_height: 0.7)
      create(:surfline_condition, surfline_spot_id: surfline_spot2.id, min_height: 0.5, max_height: 0.7)

      get forecast_url, params:
        {
          'spot' => {
            'city' => 'Porto',
            'date' => Time.zone.today,
            'km_radius' => 500,
            'level' => 'kook'
          }.to_json
        }
    end

    it 'responses with ok status' do
      expect(response).to have_http_status(:ok)
    end

    it 'responses with 2 spots' do
      spots_count = JSON.parse(response.body).count
      expect(spots_count).to eq 2
    end
  end

  context 'when invalid request' do
    before do
      get forecast_url, params:
        {
          'spot' => {
            'city' => city,
            'date' => DateTime.current,
            'km_radius' => km_radius,
            'level' => 'kook'
          }.to_json
        }
    end

    context 'when params are missing' do
      let(:city) { '' }
      let(:km_radius) { nil }

      it 'responses with unprocessible entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when no spots found' do
      let(:city) { 'Porto' }
      let(:km_radius) { 500 }

      it 'responses with not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'responses with no spots found message' do
        expect(response.body).to eq({ errors: { messages: ['No spots found.'], status: 404 } }.to_json)
      end
    end
  end
end
