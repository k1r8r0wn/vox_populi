FactoryGirl.define do
  factory :theme do
    sequence(:title) { |i| "Title#{i}" }
    sequence(:content) { |i| "Content#{i}" }
    user
    category
  end
end
