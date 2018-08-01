Feature: Ability To Purchase Items

  Scenario: Purchasing An Item
    Given I am on the Amazon website
      And I have items in my shopping cart
    When I navigate to view my shopping cart
    Then There is a button I can click to purchase the items
      And Clicking the purchase button takes me to a page where I can log in
