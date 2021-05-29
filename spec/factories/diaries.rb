FactoryBot.define do
  factory :diary do
    feeling { '😆' }
    body { '🎁' }
    start_time { Date.today }
    association :user
  end

  trait :yesterday do
    feeling { '🥳' }
    body { '👗' }
    start_time { Date.yesterday }
  end
end
