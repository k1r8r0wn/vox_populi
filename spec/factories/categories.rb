FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "Name#{i}" }
    association :user
  end
end
