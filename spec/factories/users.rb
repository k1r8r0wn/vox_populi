FactoryGirl.define do
  factory :user do
    username 'Username'
    sequence(:email) { |i| "email#{i}@mail.com" }
    password 'password'
    password_confirmation 'password'
  end
end
