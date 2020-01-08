Feature: Authentication
  
  Scenario: Login Successful
    Given I am on the Login Page
    When I log in with valid credentials
    Then I should be logged in

  Scenario: Login Unsuccessful
    Given I am on the Login Page
    When I log in with invalid credentials
    Then I should see an error
