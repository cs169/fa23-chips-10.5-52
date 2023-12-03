# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { 'sample event' }
    start_time { Time.zone.now }
    end_time { Time.zone.now + 1.hour }
    description { 'sample event description' }
    association :county, factory: :county
  end
end
