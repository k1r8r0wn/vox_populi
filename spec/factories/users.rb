FactoryGirl.define do
  sequence(:username) { |i| "username#{i}" }
  sequence(:email) { |i| "email#{i}@mail.com" }

  factory :user do
    username
    email
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now

    factory :admin do
      role 2
    end

    factory :moderator do
      role 1
    end
  end
end
