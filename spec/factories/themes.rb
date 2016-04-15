FactoryGirl.define do
  factory :theme do
    sequence(:title) { |i| "Title#{i}" }
    content 'Content'
    user
    category
  end
end
