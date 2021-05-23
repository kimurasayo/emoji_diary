FactoryBot.define do
  factory :user do
    nickname { 'nickname' }
    sequence(:name) { |n| "name_#{n}" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
