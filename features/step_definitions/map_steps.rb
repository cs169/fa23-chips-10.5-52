Given('I am directly on the New York state page') do
  visit '/state/NY' # Ensure this is the correct path
end

When('I navigate to the county named {string}') do |county_name|
  visit "/search?address=#{URI.encode(county_name)},NY"
end

Then('I should see search results for {string}') do |location|
  # Correctly format the expected URL
  expected_path = "/search?address=#{location.gsub(' ', '%20')},NY"
  expect(page).to have_current_path(expected_path)

  # Additional checks for the presence of content
  expect(page).to have_content('Table of Representatives')
  expect(page).to have_link('Kirsten E. Gillibrand', href: '/representatives/6')
  # Add other checks here as needed
end


# Then('I should see search results for {string}') do |location|
#   encoded_location = URI.encode(location).gsub('+', '%20') + ',NY'
#   expect(page).to have_current_path("/search?address=#{encoded_location}")
#   expect(page).to have_content('Table of Representatives')
#   expect(page).to have_link('Joseph R. Biden', href: '/representatives/3')
#   expect(page).to have_link('Kamala D. Harris', href: '/representatives/4')
#   expect(page).to have_link('Charles E. Schumer', href: '/representatives/5')
#   expect(page).to have_link('Kirsten E. Gillibrand', href: '/representatives/6')
# end


When('I click on name {string}') do |name|
  click_link(name, match: :prefer_exact)
end

Then('I should see {string} details') do |name|
  expect(page).to have_content(name)
  # Add more checks here as needed
end
