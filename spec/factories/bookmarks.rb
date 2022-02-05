FactoryBot.define do
  factory :bookmark do
    association :user
    association :diary
  end
end
