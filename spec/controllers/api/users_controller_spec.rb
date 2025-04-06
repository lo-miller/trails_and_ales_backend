require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          name: 'Test User',
          email: 'test@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'creates a new user' do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('message' => 'User created successfully')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          name: 'Test User',
          email: '',  # Invalid: empty email
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'does not create a new user' do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it 'returns an error response' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end 