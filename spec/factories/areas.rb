FactoryBot.define do
  factory :area do
    name { 'MyString' }
    address { 'MyString' }
    association :camp, factory: :camp
  end
end
