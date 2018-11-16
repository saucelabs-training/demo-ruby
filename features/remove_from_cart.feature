Feature: Cart

  Scenario: Remove From Cart
    Given I am on the Product Page
    And I have 2 items in the Cart
    When I remove 1 item
    Then I should see 1 item in the cart
