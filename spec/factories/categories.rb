FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "Name#{i}" }
    user
  end
end
