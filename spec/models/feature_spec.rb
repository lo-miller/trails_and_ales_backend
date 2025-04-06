require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe 'associations' do
    it 'has and belongs to many hikes' do
      association = described_class.reflect_on_association(:hikes)
      expect(association.macro).to eq :has_and_belongs_to_many
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      feature = build(:feature)
      expect(feature).to be_valid
    end

    it 'creates a feature with a feature_name' do
      feature = create(:feature, feature_name: 'Waterfall')
      expect(feature.feature_name).to eq 'Waterfall'
    end
  end

  describe 'associations behavior' do
    let(:feature) { create(:feature, feature_name: 'Waterfall') }
    let(:hike) { create(:hike) }

    it 'can be associated with hikes' do
      feature.hikes << hike
      expect(feature.hikes).to include(hike)
    end

    it 'can have multiple hikes' do
      hike1 = create(:hike)
      hike2 = create(:hike)
      feature.hikes << [hike1, hike2]
      expect(feature.hikes).to include(hike1, hike2)
    end
  end
end 