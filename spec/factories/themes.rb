FactoryGirl.define do
  factory :theme do
    sequence(:title) { |i| "Title#{i}" }
    sequence(:content) { |i| "Content#{i}" }
    association :user
    association :category
    association :city
  end
end
