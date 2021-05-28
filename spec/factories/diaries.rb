FactoryBot.define do
  factory :diary do
    feeling { '😆' }
    body { '🎉💐🎂🥂🎁' }
    start_time { Date.today }
    association :user
  end
end
