FactoryGirl.define do
  sequence(:email) { |i| "email#{i}@mail.com" }
  sequence(:username) { |i| "username#{i}" }

  factory :user do
    username
    email
    password 'password'
    password_confirmation 'password'

    factory :admin do
      role 2
    end

    factory :moderator do
      role 1
    end
  end
end
