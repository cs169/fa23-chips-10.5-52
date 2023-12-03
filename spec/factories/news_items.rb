# frozen_string_literal: true

FactoryBot.define do
  factory :news_item do
    title { 'Sample News Title' }
    description { 'Sample News Description' }
    link { 'http://example.com' }
    issue { 'Free Speech' }
    association :representative, factory: :representative
  end
end
