require 'rails_helper'

RSpec.describe Hike, type: :model do
  describe 'associations' do
    it 'has many saved_hikes' do
      association = described_class.reflect_on_association(:saved_hikes)
      expect(association.macro).to eq :has_many
    end

    it 'has and belongs to many features' do
      association = described_class.reflect_on_association(:features)
      expect(association.macro).to eq :has_and_belongs_to_many
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      hike = build(:hike)
      expect(hike).to be_valid
    end
  end

  describe 'validations' do
    let(:hike) { build(:hike) }

    context 'presence validations' do
      it 'requires name' do
        hike.name = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:name]).to include("can't be blank")
      end

      it 'requires latitude' do
        hike.latitude = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:latitude]).to include("can't be blank")
      end

      it 'requires longitude' do
        hike.longitude = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:longitude]).to include("can't be blank")
      end

      it 'requires state' do
        hike.state = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:state]).to include("can't be blank")
      end

      it 'requires length' do
        hike.length = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:length]).to include("can't be blank")
      end

      it 'requires difficulty' do
        hike.difficulty = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:difficulty]).to include("can't be blank")
      end

      it 'requires url' do
        hike.url = nil
        expect(hike).not_to be_valid
        expect(hike.errors[:url]).to include("can't be blank")
      end
    end
  end

  describe 'associations behavior' do
    let(:hike) { create(:hike) }
    let(:user) { create(:user) }
    let(:feature) { create(:feature, feature_name: 'Waterfall') }

    it 'can have saved_hikes' do
      saved_hike = create(:saved_hike, hike: hike, user: user)
      expect(hike.saved_hikes).to include(saved_hike)
    end

    it 'can have features' do
      hike.features << feature
      expect(hike.features).to include(feature)
    end

    it 'can be destroyed without affecting features' do
      hike.features << feature
      feature_id = feature.id
      hike.destroy
      expect(Feature.find_by(id: feature_id)).to be_present
    end
  end

  describe 'data integrity' do
    let(:hike) { create(:hike) }

    it 'can store decimal length values' do
      hike.length = 5.5
      expect(hike.save).to be true
      expect(hike.reload.length).to eq 5.5
    end

    it 'can store decimal elevation gain values' do
      hike.elevation_gain = 1000.5
      expect(hike.save).to be true
      expect(hike.reload.elevation_gain).to eq 1000.5
    end

    it 'can store coordinates' do
      hike.latitude = 47.6062
      hike.longitude = -122.3321
      expect(hike.save).to be true
      expect(hike.reload.latitude).to eq 47.6062
      expect(hike.reload.longitude).to eq -122.3321
    end
  end
end 