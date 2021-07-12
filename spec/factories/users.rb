FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user-#{n}" }
    sequence(:email) {|n| "test-#{n}@example.com"}
    password { 'password' }
    password_confirmation { 'password' }
    #afterメソッド。userインスタンスをbuildした後、画像をつける。
    after(:build) do |user|
      user.avatar.attach(io: File.open('spec/fixtures/files/sample.jpeg'), filename: 'sample.jpeg', content_type: 'image/jpeg')
    end
  end

  factory :guest_user, class: User do
    name {'guest_user'}
    email {'guest_user@example.com'}
    password {'password'}
    password_confirmation {'password'}
    #afterメソッド。userインスタンスをbuildした後、画像をつける。
    after(:build) do |user|
      user.avatar.attach(io: File.open('spec/fixtures/files/sample.jpeg'), filename: 'sample.jpeg', content_type: 'image/jpeg')
    end
  end
end
