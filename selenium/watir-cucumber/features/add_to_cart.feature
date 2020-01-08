Feature: Cart

  Scenario Outline: Adding
    Given I am on the Product Page
    When I add <number> items
    Then I should see <number> items in the cart
    Examples:
      | number |
      | 1      |
      | 2      |
