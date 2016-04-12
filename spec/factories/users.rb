FactoryGirl.define do
  factory :user do
    sequence(:username) { |i| "username#{i}" }
    sequence(:email) { |i| "email#{i}@mail.com" }
    password 'password'
    password_confirmation 'password'
  end
end
