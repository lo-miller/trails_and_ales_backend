require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = User.new(
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(
        name: 'First User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      
      user = User.new(
        name: 'Second User',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many saved_hikes' do
      association = described_class.reflect_on_association(:saved_hikes)
      expect(association.macro).to eq :has_many
    end
  end
end
