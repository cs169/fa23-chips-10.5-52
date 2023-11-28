Feature: Viewing a Representative's Profile
  As a user
  I want to see detailed information about a representative
  So that I can learn more about them

  Scenario: User searches for representatives in New York and views Kirsten E. Gillibrand's profile
    Given I navigate to the representatives list page
    When I enter "New York" into the address field
    When I press the search button
    Then I should see the search results for "New York"
    When I click on "Kirsten E. Gillibrand"
    Then I view the detailed profile for "Kirsten E. Gillibrand"
