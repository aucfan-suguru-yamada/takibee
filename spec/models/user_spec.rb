require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'is invalid without name' do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'is invalid without email' do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください"]
    end

    it 'is invalid duplicate email' do
      user = create(:user, email: "test@example.com")
      duplicate_user = build(:user, email: "test@example.com")
      expect(duplicate_user).to be_invalid
      expect(duplicate_user.errors[:email]).to eq ["はすでに存在します"]
    end
  end
end