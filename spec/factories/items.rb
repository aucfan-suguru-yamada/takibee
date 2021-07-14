FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "name-#{n}" }
    association :maker, factory: :maker
  end
end
