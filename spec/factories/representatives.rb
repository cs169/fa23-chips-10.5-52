# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    ocdid { 'ocd-Sample-Representative' }
    name { 'Sample Representative' }
    title { 'Sample Title' }
    street { '456 University Street' }
    city { 'Berkeley' }
    state { 'CA' }
    zip { '121212' }
    party { 'Sample Party' }
    photo_url { 'https://example.com/sample_photo.jpg' }
  end
end
