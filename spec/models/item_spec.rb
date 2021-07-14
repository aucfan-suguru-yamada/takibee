require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      item = build(:item)
      expect(item).to be_valid
      expect(item.errors).to be_empty
    end

    it 'is invalid without name' do
      item_without_name = build(:item, name: "")
      expect(item_without_name).to be_invalid
      expect(item_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid duplicate email' do
      item = create(:item, name: "test_name")
      duplicate_item = build(:item, name: "test_name")
      expect(duplicate_item).to be_invalid
      expect(duplicate_item.errors[:name]).to eq ["はすでに存在します"]
    end
  end
end