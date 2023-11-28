Feature: County Selection on Map
  As a user of the ActionMap application
  I want to be able to click on a county in the map
  So that I can view the representatives for that county

  Scenario: User navigates through State counties and views a representative
    Given I go to the home page
    When I go to New York
    When I go to Hamilton County
    Then I should see the search results for "New York"
    When I click on "Elise Stefanik"
    Then I view the detailed profile for "Elise Stefanik"


    Given I go to the home page
    When I go to Hawaii
    Then I go to Hawaii County
    Then I should see "Joseph R. Biden"
    Then I should see "Kamala D. Harris"
    Then I should see "Brian Schatz"
    Then I should see "Mazie K. Hirono"
    Then I should see "Jill N. Tokuda"
    Then I should see "Josh Green"
    Then I should see "Sylvia Luke"
    Then I should see "Brickwood Galuteria"


