require 'page-object'
require 'watir'
require_relative '../workflows/navigation'
require_relative '../workflows/searching'
include Navigation
include Searching


Then(/^There is a button I can click to purchase the items$/) do
  expect(@browser.span(id: 'sc-buy-box-ptc-button').exists?).to be true
  expected_text = 'Proceed to checkout'
  text_on_button = @browser.span(id: 'sc-buy-box-ptc-button').text
  expect(text_on_button).to eq(expected_text)
end

And(/^Clicking the purchase button takes me to a page where I can log in$/) do
  @browser.span(id: 'sc-buy-box-ptc-button').click
  expected_text = 'Sign in'
  text_from_page = @browser.form(name: 'signIn').text
  expect(text_from_page).to include(expected_text)
end
