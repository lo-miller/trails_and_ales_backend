require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          name: 'Test User',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
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

      it 'creates user with correct attributes' do
        post :create, params: valid_params
        user = User.last
        expect(user.name).to eq(valid_params[:name])
        expect(user.email).to eq(valid_params[:email])
      end
    end

    context 'with invalid parameters' do
      context 'when email is missing' do
        let(:invalid_params) do
          {
            name: 'Test User',
            password: 'password123',
            password_confirmation: 'password123'
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
          expect(JSON.parse(response.body)['errors']).to include("Email can't be blank")
        end
      end

      context 'when password confirmation does not match' do
        let(:invalid_params) do
          {
            name: 'Test User',
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'different_password'
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
          expect(JSON.parse(response.body)['errors']).to include("Password confirmation doesn't match Password")
        end
      end

      context 'when email is already taken' do
        before do
          create(:user, email: 'test@example.com')
        end

        let(:duplicate_email_params) do
          {
            name: 'Another User',
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password123'
          }
        end

        it 'does not create a new user' do
          expect {
            post :create, params: duplicate_email_params
          }.not_to change(User, :count)
        end

        it 'returns an error response' do
          post :create, params: duplicate_email_params
          expect(response).to have_http_status(:bad_request)
          expect(JSON.parse(response.body)['errors']).to include('Email has already been taken')
        end
      end
    end
  end
end 