FactoryGirl.define do
  factory :city do
    sequence(:name) { |i| "Name#{i}" }
    sequence(:ru_name) { |i| "Name#{i}" }
  end
end
