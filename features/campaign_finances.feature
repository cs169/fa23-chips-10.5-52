Feature: Campaign Finances Search
  As a user
  I want to search for campaign finance information
  So that I can view financial data of candidates
  
   Scenario: Selecting cycle and category to view campaign finance data
    Given I navigate to the Campaign Finances page
    Then I should see "2010"
    Then I should see "2012"
    Then I should see "2014"
    Then I should see "2016"
    Then I should see "2018"
    Then I should see "2020"
    
    Then I should see "Candidate Loan"
    Then I should see "Contribution Total"
    Then I should see "Debts Owed"
    Then I should see "Disbursements Total"
    Then I should see "End Cash"
    Then I should see "Individual Total"
    Then I should see "PAC Total"
    Then I should see "Receipts Total"
    Then I should see "Refund Total"

    When I select "2010" from the "cycle" dropdown
    And I select "PAC Total" from the "category" dropdown
    And I press "Search"
    Then I should see a table with campaign finance data
    Then I should see "LINCOLN, BLANCHE LAMBERT"
    Then I should see "REID, HARRY"
    Then I should see "BLUNT, ROY"
    Then I should see "SCHUMER, CHARLES E"
