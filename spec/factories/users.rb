FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) {|n| "test-#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :guest_user, class: User do
    name {'guest_user'}
    email {'guest_user@example.com'}
    password {'password'}
    password_confirmation {'password'}
  end
end
