FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
