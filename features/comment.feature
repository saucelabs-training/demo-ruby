Feature: Guinea Pig comment

  Scenario: Verify comment text
    Given I am on the Guinea Pig homepage
    When I submit a comment
    Then I should see that comment displayed
