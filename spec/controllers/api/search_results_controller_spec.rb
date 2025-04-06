require 'rails_helper'

RSpec.describe Api::SearchResultsController, type: :controller do
  let(:mock_response) { instance_double(HTTP::Response) }
  let(:mock_parsed_response) { { 'results' => [] } }

  before do
    allow(HTTP).to receive(:get).and_return(mock_response)
    allow(mock_response).to receive(:parse).and_return(mock_parsed_response)
  end

  describe 'GET #state_geographic_center' do
    let(:address) { 'Washington State' }
    let(:api_key) { Rails.application.credentials.google_maps_api[:api_key] }

    it 'makes a request to the Google Geocoding API' do
      expect(HTTP).to receive(:get).with(
        "https://maps.googleapis.com/maps/api/geocode/json?&key=#{api_key}",
        params: { address: address }
      )
      get :state_geographic_center, params: { address: address }
    end

    it 'returns the parsed response' do
      get :state_geographic_center, params: { address: address }
      expect(response.body).to eq(mock_parsed_response.to_json)
    end

    context 'when API request fails' do
      before do
        allow(HTTP).to receive(:get).and_raise(HTTP::Error)
      end

      it 'handles the error appropriately' do
        get :state_geographic_center, params: { address: address }
        expect(response).to have_http_status(:service_unavailable)
      end
    end
  end

  describe 'GET #brewery_search_index' do
    let(:location) { '47.6062,-122.3321' }
    let(:radius) { '5000' }
    let(:api_key) { Rails.application.credentials.google_maps_api[:api_key] }

    it 'makes a request to the Google Places API' do
      expect(HTTP).to receive(:get).with(
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=brewery&keyword=brewery&key=#{api_key}",
        params: { location: location, radius: radius }
      )
      get :brewery_search_index, params: { location: location, radius: radius }
    end

    it 'returns the parsed response' do
      get :brewery_search_index, params: { location: location, radius: radius }
      expect(response.body).to eq(mock_parsed_response.to_json)
    end

    context 'when API request fails' do
      before do
        allow(HTTP).to receive(:get).and_raise(HTTP::Error)
      end

      it 'handles the error appropriately' do
        get :brewery_search_index, params: { location: location, radius: radius }
        expect(response).to have_http_status(:service_unavailable)
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show
      expect(response).to render_template('show.json.jb')
    end
  end
end 