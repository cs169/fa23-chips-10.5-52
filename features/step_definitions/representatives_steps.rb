# frozen_string_literal: true

Given('I navigate to the representatives list page') do
  visit '/representatives' 
end

When('I enter {string} into the address field') do |value|
  fill_in 'address', with: value
end

When('I press the search button') do
  click_button('Search')
end

When('I click on{string}') do |link|
  click_link(link, match: :prefer_exact)
end

Then('I should see the search results for {string}') do |location|
  expect(page).to have_content('Table of Representatives')
  expect(page).to have_content(location)
end

When('I click on {string}') do |name|
  click_link(name, match: :prefer_exact)
end

Then('I view the detailed profile for {string}') do |name|
  representative = Representative.find_by(name: name)
  expect(current_path).to eq("/representatives/#{representative.id}")
  expect(page).to have_content(name)
end

Then('I should see {string} details') do |name|
  expect(page).to have_content(name)
  expect(page).to have_content(representative.title)
  expect(page).to have_selector("img[src='#{representative.photo_url}']") if representative.photo_url.present?
  expect(page).to have_content(representative.street)
  expect(page).to have_content(representative.city)
  expect(page).to have_content(representative.state)
  expect(page).to have_content(representative.zip)
  expect(page).to have_content(representative.party)
end
