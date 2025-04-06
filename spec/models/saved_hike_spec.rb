require 'rails_helper'

RSpec.describe SavedHike, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a hike' do
      association = described_class.reflect_on_association(:hike)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      saved_hike = build(:saved_hike)
      expect(saved_hike).to be_valid
    end
  end

  describe 'attributes' do
    let(:saved_hike) { create(:saved_hike, status: 'completed', brewery_name: 'Test Brewery') }

    it 'has a status' do
      expect(saved_hike.status).to eq 'completed'
    end

    it 'has a brewery name' do
      expect(saved_hike.brewery_name).to eq 'Test Brewery'
    end
  end

  describe 'relationships' do
    let(:user) { create(:user) }
    let(:hike) { create(:hike) }
    let(:saved_hike) { create(:saved_hike, user: user, hike: hike) }

    it 'associates with the correct user' do
      expect(saved_hike.user).to eq user
    end

    it 'associates with the correct hike' do
      expect(saved_hike.hike).to eq hike
    end
  end
end 