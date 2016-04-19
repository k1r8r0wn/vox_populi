FactoryGirl.define do
  factory :comment do
    sequence(:content) { |i| "Content#{i}" }
    user
  end
end
