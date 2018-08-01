Feature: Searching For Specific Items

  Scenario: Searching For Item Using The Search Box
    Given I am on the Amazon website
    When I type in a product name into the search box
      And I click the search button
    Then I should be redirected to a page which shows a list of products matching the search parameter
