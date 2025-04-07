require 'rails_helper'

RSpec.describe Api::SavedHikesController, type: :controller do
  let(:user) { create(:user) }
  let(:hike) { create(:hike) }

  # Helper method to simulate authenticated user
  def authenticate_user(user)
    token = JWT.encode(
      { user_id: user.id, exp: 24.hours.from_now.to_i },
      Rails.application.credentials.fetch(:secret_key_base),
      'HS256'
    )
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    let!(:saved_hikes) { create_list(:saved_hike, 3, user: user, status: 'saved') }
    let!(:completed_hike) { create(:saved_hike, user: user, status: 'completed') }
    let!(:other_user_hike) { create(:saved_hike, status: 'saved') }

    before do
      authenticate_user(user)
    end

    it 'returns only saved hikes for the current user' do
      get :index
      expect(assigns(:saved_hikes)).to match_array(saved_hikes)
      expect(assigns(:saved_hikes)).not_to include(completed_hike)
      expect(assigns(:saved_hikes)).not_to include(other_user_hike)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized status' do
        request.headers['Authorization'] = nil
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        hike_id: hike.id,
        brewery_name: 'Test Brewery'
      }
    end

    before do
      authenticate_user(user)
    end

    context 'with valid parameters' do
      it 'creates a new saved hike' do
        expect {
          post :create, params: valid_params
        }.to change(SavedHike, :count).by(1)
      end

      it 'assigns the correct attributes' do
        post :create, params: valid_params
        saved_hike = assigns(:saved_hike)
        expect(saved_hike.user_id).to eq(user.id)
        expect(saved_hike.hike_id).to eq(hike.id)
        expect(saved_hike.status).to eq('saved')
        expect(saved_hike.brewery_name).to eq('Test Brewery')
      end

      it 'renders the show template' do
        post :create, params: valid_params
        expect(response).to render_template(:show)
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized status' do
        request.headers['Authorization'] = nil
        post :create, params: valid_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end 