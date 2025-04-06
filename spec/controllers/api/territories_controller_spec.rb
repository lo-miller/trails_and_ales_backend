require 'rails_helper'

RSpec.describe Api::TerritoriesController, type: :controller do
  describe 'GET #index' do
    let(:location) { '47.6062,-122.3321' } # Example coordinates for Seattle
    let(:mock_parsed_response) { [
      {
        "name" => "Coast Salish",
        "description" => "Coast Salish territory",
        "id" => "123"
      }
    ] }

    context 'when the API request is successful' do
      before do
        # Create a mock HTTP response
        mock_response = double('HTTP::Response')
        allow(mock_response).to receive(:parse).and_return(mock_parsed_response)
        
        # Mock the HTTP.get call
        allow(HTTP).to receive(:get)
          .with(
            "https://native-land.ca/api/index.php?maps=territories",
            params: { position: location }
          )
          .and_return(mock_response)
      end

      it 'makes a request to the Native Land API' do
        expect(HTTP).to receive(:get)
          .with(
            "https://native-land.ca/api/index.php?maps=territories",
            params: { position: location }
          )
        
        get :index, params: { location: location }
      end

      it 'returns a successful response' do
        get :index, params: { location: location }
        expect(response).to have_http_status(:success)
      end

      it 'returns the parsed response body' do
        get :index, params: { location: location }
        expect(JSON.parse(response.body)).to eq(mock_parsed_response)
      end
    end

    context 'when the API request fails' do
      before do
        allow(HTTP).to receive(:get).and_raise(HTTP::Error.new("API Error"))
      end

      it 'returns a service unavailable status' do
        get :index, params: { location: location }
        expect(response).to have_http_status(:service_unavailable)
      end

      it 'returns an error message' do
        get :index, params: { location: location }
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Native Land API service unavailable' })
      end
    end
  end
end 