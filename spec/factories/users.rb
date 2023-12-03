# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider { 1 }
    uid { 'e-uid' }
    email { '169@berkley.com' }
    first_name { 'Saeed' }
    last_name { 'Ebrahimi' }
  end
end
