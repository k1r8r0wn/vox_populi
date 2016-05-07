FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "Name#{i}" }
    sequence(:ru_name) { |i| "Название#{i}" }
    association :user
  end
end
