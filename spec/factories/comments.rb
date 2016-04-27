FactoryGirl.define do
  factory :comment do
    sequence(:content) { |i| "Content#{i}" }
    association :user
    association :theme
  end
end
