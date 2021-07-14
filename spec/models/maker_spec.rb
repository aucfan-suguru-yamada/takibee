require 'rails_helper'

RSpec.describe Maker, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      maker = build(:maker)
      expect(maker).to be_valid
      expect(maker.errors).to be_empty
    end

    it 'is invalid without name' do
      maker_without_name = build(:maker, name: "")
      expect(maker_without_name).to be_invalid
      expect(maker_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid duplicate email' do
      maker = create(:maker, name: "test_name")
      duplicate_maker = build(:maker, name: "test_name")
      expect(duplicate_maker).to be_invalid
      expect(duplicate_maker.errors[:name]).to eq ["はすでに存在します"]
    end
  end
end