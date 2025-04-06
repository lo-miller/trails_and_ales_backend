require 'rails_helper'

RSpec.describe Api::HikesController, type: :controller do
  describe 'GET #index' do
    let!(:wa_hikes) { create_list(:hike, 3, state: 'WA') }
    let!(:or_hikes) { create_list(:hike, 2, state: 'OR') }
    let!(:specific_hike) { create(:hike, id: 5211) }

    context 'when no state is specified' do
      it 'returns WA hikes by default' do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:hikes)).to include(*wa_hikes)
      end

      it 'includes hike with ID 5211 if it exists' do
        get :index
        expect(assigns(:hikes)).to include(specific_hike)
      end

      it 'limits the response to 100 hikes' do
        create_list(:hike, 150, state: 'WA')
        get :index
        wa_hikes_count = assigns(:hikes).count { |hike| hike.state == 'WA' }
        expect(wa_hikes_count).to be <= 100
      end
    end

    context 'when state is specified' do
      it 'returns hikes from the specified state' do
        get :index, params: { state: 'OR' }
        expect(assigns(:hikes)).to include(*or_hikes)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index.json.jb')
      end
    end
  end

  describe 'GET #show' do
    let!(:hike) { create(:hike) }

    context 'when the hike exists' do
      before { get :show, params: { id: hike.id } }

      it 'assigns the requested hike' do
        expect(assigns(:hike)).to eq(hike)
      end

      it 'renders the show template' do
        expect(response).to render_template('show.json.jb')
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the hike does not exist' do
      before { get :show, params: { id: 999999 } }

      it 'assigns nil to @hike' do
        expect(assigns(:hike)).to be_nil
      end

      it 'still renders the show template' do
        expect(response).to render_template('show.json.jb')
      end
    end
  end
end 