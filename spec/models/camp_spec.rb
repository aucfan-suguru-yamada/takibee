require 'rails_helper'

RSpec.describe Camp, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      camp = build(:camp)
      expect(camp).to be_valid
      expect(camp.errors).to be_empty
    end

    it 'is invalid without title' do
      camp_without_title = build(:camp, title: "")
      expect(camp_without_title).to be_invalid
      expect(camp_without_title.errors[:title]).to eq ["を入力してください"]
    end
  end
end