require 'page-object'
require 'watir'
require_relative '../workflows/navigation'
require_relative '../workflows/searching'
include Navigation
include Searching


Given(/^I am on the Amazon website$/) do
  @amazon = Amazon.new(@browser)
  @amazon.goto_amazon
  @browser.span(id: 'nav-cart-count').wait_until_present
end

When(/^I type in a product name into the search box$/) do
  @search_term = 'Watership Down'
  @amazon.enter_search_term(@search_term)
end

And(/^I click the search button$/) do
  @amazon.click_on_search_button
end

Then(/^I should be redirected to a page which shows a list of products matching the search parameter$/) do
  @browser.link(id: 's-results-list-atf').exists?
  text_in_results_list = @browser.ul(id: 's-results-list-atf').text
  expect(text_in_results_list).to include(@search_term)
end
