require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'POST #create' do
    let(:user_password) { 'password123' }
    let!(:user) { create(:user, password: user_password, password_confirmation: user_password) }

    context 'with valid credentials' do
      let(:valid_params) do
        {
          email: user.email,
          password: user_password
        }
      end

      it 'returns a JWT token' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('jwt', 'email', 'user_id')
      end

      it 'returns the correct user information' do
        post :create, params: valid_params
        json_response = JSON.parse(response.body)
        expect(json_response['email']).to eq(user.email)
        expect(json_response['user_id']).to eq(user.id)
      end

      it 'returns a valid JWT token' do
        post :create, params: valid_params
        token = JSON.parse(response.body)['jwt']
        decoded_token = JWT.decode(
          token,
          Rails.application.credentials.fetch(:secret_key_base),
          true,
          algorithm: 'HS256'
        )
        expect(decoded_token.first['user_id']).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      context 'when email is incorrect' do
        let(:invalid_params) do
          {
            email: 'wrong@example.com',
            password: user_password
          }
        end

        it 'returns unauthorized status' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns an empty response body' do
          post :create, params: invalid_params
          expect(JSON.parse(response.body)).to be_empty
        end
      end

      context 'when password is incorrect' do
        let(:invalid_params) do
          {
            email: user.email,
            password: 'wrong_password'
          }
        end

        it 'returns unauthorized status' do
          post :create, params: invalid_params
          expect(response).to have_http_status(:unauthorized)
        end

        it 'returns an empty response body' do
          post :create, params: invalid_params
          expect(JSON.parse(response.body)).to be_empty
        end
      end
    end
  end
end 