require 'page-object'
require 'watir'
require_relative '../workflows/navigation'
require_relative '../workflows/searching'
require_relative '../workflows/shopping_cart'
include Navigation
include Searching
include ShoppingCart


And(/^I navigate to a specific item$/) do
  @amazon.goto_watership_down
end

When(/^I click the button to add the item to my shopping cart$/) do
  @browser.span(id: 'nav-cart-count').wait_until_present
  @items_in_cart_before_add = @browser.span(id: 'nav-cart-count').text
  @amazon.add_to_cart
end

Then(/^The item is successfully added to my shopping cart$/) do
  @browser.span(id: 'nav-cart-count').wait_until_present
  @items_in_cart_after_add = @browser.span(id: 'nav-cart-count').text
  expect(@items_in_cart_before_add.to_i + 1).to eq(@items_in_cart_after_add.to_i)
end

And(/^I have items in my shopping cart$/) do
  @amazon.goto_watership_down
  @product_title_1 = @browser.span(id: 'productTitle').text
  @amazon.add_to_cart

  @amazon.goto_devops_handbook
  @product_title_2 = @browser.span(id: 'productTitle').text
  @amazon.add_to_cart

  @amazon.goto_clean_code
  @product_title_3 = @browser.span(id: 'productTitle').text
  @amazon.add_to_cart

  @amazon.goto_phoenix_project
  @product_title_4 = @browser.span(id: 'productTitle').text
  @amazon.add_to_cart

  @amazon.goto_sword_of_shannara
  @product_title_5 = @browser.span(id: 'productTitle').text

  basic_text = @browser.div(id: 'detail-bullets').text
  isbn_10_line = basic_text.split("\n")[5]
  expect(isbn_10_line).to include('ISBN-10:')
  @isbn_10 = isbn_10_line.split(":")[-1].strip

  @amazon.add_to_cart
end

When(/^I click the button to view my shopping cart$/) do
  @browser.span(id: 'nav-cart-count').click
end

Then(/^I should see a list of all the items in my shopping cart$/) do
  text_from_page_element = @browser.div(class: 'sc-cart-header').text
  expect(text_from_page_element).to eq("Shopping Cart")

  browser_text = @browser.div(class: 'sc-list-body').text
  expect(browser_text).to include(@product_title_1)
  expect(browser_text).to include(@product_title_2)
  expect(browser_text).to include(@product_title_3)
  expect(browser_text).to include(@product_title_4)
  expect(browser_text).to include(@product_title_5)
end

And(/^I have an item in my shopping cart$/) do
  @amazon.goto_watership_down
  @product_title_1 = @browser.span(id: 'productTitle').text
  @amazon.add_to_cart
end

And(/^I navigate to view my shopping cart$/) do
  @browser.span(id: 'nav-cart-count').click
end

When(/^I change the quantity of an item in my cart$/) do
  @cart_count_before_qty_change = @browser.span(id: 'nav-cart-count').text
  @initial_value = @browser.select_list(name: 'quantity').text
  @selected_value = '2'
  @browser.select_list(name: 'quantity').select(@selected_value)
end

Then(/^The quantity of that item changes to the value I selected$/) do
  new_value = @browser.select_list(name: 'quantity').text
  expect(new_value).not_to eq(@initial_value)
  expect(new_value).to eq(@selected_value)
end

When(/^I click to remove the item from my shopping cart$/) do
  @list_text_single = @browser.div(class: 'sc-list-body').text
  @browser.input(value: 'Delete').click
end

Then(/^The item it removed from my shopping cart$/) do
  while @list_text_single == @browser.div(class: 'sc-list-body').text do
    sleep(1)
  end
  expected_text_removal_portion = ' was removed from Shopping Cart.'
  updated_list_text = @browser.div(class: 'sc-list-body').text
  expect(updated_list_text).to eq(@product_title_1 + expected_text_removal_portion)
end

And(/^My shopping cart is empty$/) do
  expected_text = 'Your Shopping Cart is empty.'
  updated_cart_text = @browser.div(id: 'sc-active-cart').text
  expect(updated_cart_text).to include(expected_text)
end

And(/^The number of items in my shopping cart is zero$/) do
  @items_in_cart_after_deletion = @browser.span(id: 'nav-cart-count').text
  expect(@items_in_cart_after_deletion.to_i).to eq(0)
end

When(/^I click to delete a specific item from my shopping cart$/) do
  @list_text_multiple_del = @browser.div(class: 'sc-list-body').text
  @items_in_cart_before_deletion = @browser.span(id: 'nav-cart-count').text
  @browser.div('data-asin': @isbn_10).input(value: 'Delete').click
end

Then(/^The selected item is successfully removed$/) do
  while @list_text_multiple_del == @browser.div(class: 'sc-list-body').text do
    sleep(1)
  end
  expected_text_removal_portion = ' was removed from Shopping Cart.'
  updated_list_text = @browser.div(class: 'sc-list-body').text
  expected_text = @product_title_5 + expected_text_removal_portion
  expect(updated_list_text).to include(expected_text)
end

And(/^The item no longer appears in my shopping cart$/) do
  @browser.refresh
  updated_list = @browser.div(class: 'sc-list-body').text
  expect(updated_list).to_not include(@product_title_5)
end

And(/^My shopping cart shows the updated number of items after deleting$/) do
  items_after_deletion = @browser.span(id: 'nav-cart-count').text
  expect(items_after_deletion.to_i).to eq(@items_in_cart_before_deletion.to_i - 1)
end

And(/^My shopping cart shows an updated count of items due to the quantity change$/) do
  while @cart_count_before_qty_change == @browser.span(id: 'nav-cart-count').text do
    sleep(1)
  end
  updated_cart_count = @browser.span(id: 'nav-cart-count').text
  expect(updated_cart_count).to eq(@selected_value)
end

When(/^I click to save a specific item for later$/) do
  @list_text_multiple_save = @browser.div(class: 'sc-list-body').text
  @items_in_cart_before_save = @browser.span(id: 'nav-cart-count').text
  @browser.div('data-asin': @isbn_10).input(value: 'Save for later').click
end

Then(/^The selected item is successfully saved for later$/) do
  while @list_text_multiple_save == @browser.div(class: 'sc-list-body').text do
    sleep(1)
  end
  expected_text_save_portion = ' has been moved to Save for Later.'
  updated_list_text = @browser.div(class: 'sc-list-body').text
  expected_text = @product_title_5 + expected_text_save_portion
  expect(updated_list_text).to include(expected_text)
end

And(/^The selected item appears in the saved for later list$/) do
  save_list_text = @browser.form(id: 'savedCartViewForm').text
  expect(save_list_text).to include(@product_title_5)
end

And(/^My shopping cart shows the updated number of items after saving$/) do
  items_after_saving = @browser.span(id: 'nav-cart-count').text
  expect(items_after_saving.to_i).to eq(@items_in_cart_before_save.to_i - 1)
end