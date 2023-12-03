# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    sequence(:name) { |n| "State #{n}" }
    sequence(:symbol) { |n| "S#{n}" }
    sequence(:fips_code) { |n| n }
    is_territory { false }
    lat_min { rand(-90.0..90.0) }
    lat_max { rand(-90.0..90.0) }
    long_min { rand(-180.0..180.0) }
    long_max { rand(-180.0..180.0) }
  end
end
