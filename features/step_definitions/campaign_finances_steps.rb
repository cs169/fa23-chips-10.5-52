# frozen_string_literal: true

Given('I navigate to the Campaign Finances page') do
  visit '/campaignfinances'
end

When(/^I select "(.*)" from the "(.*)" dropdown$/) do |option, field|
  select(option, from: field)
end

Then('I should see a table with campaign finance data') do
  expect(page).to have_css('table#events')
end
