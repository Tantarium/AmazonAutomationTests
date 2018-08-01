Feature: Shopping Cart Capabilities

  Scenario: Adding Something To Shopping Cart
    Given I am on the Amazon website
      And I navigate to a specific item
    When I click the button to add the item to my shopping cart
    Then The item is successfully added to my shopping cart

  Scenario: Able To View A List Of Items In Shopping Cart
    Given I am on the Amazon website
      And I have items in my shopping cart
    When I click the button to view my shopping cart
    Then I should see a list of all the items in my shopping cart

  Scenario: Changing The Quantity Of An Item In Shopping Cart
    Given I am on the Amazon website
      And I have an item in my shopping cart
      And I navigate to view my shopping cart
    When I change the quantity of an item in my cart
    Then The quantity of that item changes to the value I selected
      And My shopping cart shows an updated count of items due to the quantity change

  Scenario: Deleting Only Item In Shopping Cart With One Item
    Given I am on the Amazon website
      And I have an item in my shopping cart
      And I navigate to view my shopping cart
    When I click to remove the item from my shopping cart
    Then The item it removed from my shopping cart
      And My shopping cart is empty
      And The number of items in my shopping cart is zero

  Scenario: Deleting A Single Item From Shopping Cart With Multiple Items
    Given I am on the Amazon website
      And I have items in my shopping cart
      And I navigate to view my shopping cart
    When I click to delete a specific item from my shopping cart
    Then The selected item is successfully removed
      And The item no longer appears in my shopping cart
      And My shopping cart shows the updated number of items
      #And The subtotal for my shopping cost successfully updates

  Scenario: Saving An Item For Later
    Given I am on the Amazon website
      And I have items in my shopping cart
      And I navigate to view my shopping cart
    When I click to save a specific item for later
    Then The selected item is successfully saved for later
      And The selected item appears in the saved for later list
      And My shopping cart shows the updated number of items
      #And The subtotal for the shopping cart successfully updates