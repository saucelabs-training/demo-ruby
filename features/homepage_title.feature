Feature: Guinea Pig homepage

  Scenario: Verify homepage title
    Given I am on the Guinea Pig homepage
    Then the title of the page should be
      """
      I am a page title - Sauce Labs
      """
