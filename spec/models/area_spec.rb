require 'rails_helper'

RSpec.describe Area, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      area = build(:area)
      expect(area).to be_valid
      expect(area.errors).to be_empty
    end

    it 'is invalid without name' do
      area_without_name = build(:area, name: "")
      expect(area_without_name).to be_invalid
      expect(area_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid without address' do
      area_without_address = build(:area, address: "")
      expect(area_without_address).to be_invalid
      expect(area_without_address.errors[:address]).to eq ["を入力してください"]
    end
  end
end