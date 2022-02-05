FactoryBot.define do
  factory :user do
    nickname { '🐶' }
    sequence(:name) { |n| "name#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    role { "general" }
    color { "pink" }
  end

  trait :admin do
    sequence(:name, "admin1")
    sequence(:email) { |n| "admin#{n}@example.com" }
    role { "admin" }
  end

  trait :blue do
    sequence(:name, "blue1")
    sequence(:email) { |n| "blue#{n}@example.com" }
    color { "blue" }
  end
end
