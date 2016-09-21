Feature: Guinea Pig homepage

  Scenario: Verify email input
    Given I am on the Guinea Pig homepage
    When I type "abc" in the email text field
    Then I should see "abc" in the email text field
