FactoryGirl.define do
  factory :provider do
    name 'Provider'
    uid '123456789'
    association :user
  end
end
