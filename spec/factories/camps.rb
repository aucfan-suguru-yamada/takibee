FactoryBot.define do
  factory :camp do
    sequence(:title) { |n| "title-#{n}" }
    sequence(:note) {|n| "note-#{n}"}
    sequence(:number_of_people) {|n| n}
  end
end
