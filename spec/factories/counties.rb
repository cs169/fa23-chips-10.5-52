# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    association :state, factory: :state
    sequence(:name) { |n| "County #{n}" }
    sequence(:fips_code) { |n| n }
    fips_class { 'H1' }
  end
end
