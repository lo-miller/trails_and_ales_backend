require 'rails_helper'

RSpec.describe Api::HikesController, type: :controller do
  describe 'GET #index' do
    let!(:wa_hikes) { create_list(:hike, 3, state: 'WA') }
    let!(:or_hikes) { create_list(:hike, 2, state: 'OR') }
    
    context 'when no state is specified' do
      before { get :index, format: :json }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all hikes' do
        expect(assigns(:hikes)).to include(*wa_hikes, *or_hikes)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context 'when state is specified' do
      before { get :index, params: { state: 'OR' }, format: :json }

      it 'returns hikes from the specified state' do
        expect(assigns(:hikes)).to include(*or_hikes)
      end

      it 'does not return hikes from other states' do
        expect(assigns(:hikes)).not_to include(*wa_hikes)
      end
    end

    context 'pagination and limits' do
      before do
        create_list(:hike, 150, state: 'WA')
      end

      it 'limits results to 100 hikes per state' do
        get :index, format: :json
        expect(assigns(:hikes).length).to be <= 100
      end
    end
  end

  describe 'GET #show' do
    context 'when the hike exists' do
      let!(:hike) { create(:hike) }

      before { get :show, params: { id: hike.id }, format: :json }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns the requested hike' do
        expect(assigns(:hike)).to eq(hike)
      end

      it 'renders the show template' do
        get :show, params: { id: hike.id }, format: :json
        expect(response).to render_template(:show)
      end
    end

    context 'when the hike does not exist' do
      before { get :show, params: { id: 999999 }, format: :json }

      it 'returns http success even when hike is not found' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns nil to @hike' do
        expect(assigns(:hike)).to be_nil
      end

      it 'still renders the show template' do
        get :show, params: { id: 999999 }, format: :json
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'edge cases' do
    context 'when state parameter is invalid' do
      it 'handles empty state parameter' do
        get :index, params: { state: '' }, format: :json
        expect(response).to have_http_status(:success)
        expect(assigns(:hikes)).not_to be_nil
      end

      it 'handles non-existent state' do
        get :index, params: { state: 'XX' }, format: :json
        expect(response).to have_http_status(:success)
        expect(assigns(:hikes)).to be_empty
      end
    end

    context 'when dealing with special characters' do
      it 'handles state names with spaces' do
        create(:hike, state: 'New York')
        get :index, params: { state: 'New York' }, format: :json
        expect(response).to have_http_status(:success)
      end

      it 'handles state names with special characters' do
        create(:hike, state: "Hawai'i")
        get :index, params: { state: "Hawai'i" }, format: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end 