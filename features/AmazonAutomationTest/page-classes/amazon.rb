require 'page-object'
require 'watir'

class Amazon
  include PageObject
  page_url "amazon.com"
  text_field(:search_box, id: 'twotabsearchtextbox')
  button(:search_button, class: 'nav-input')
  link(:first_item, class: 'a-inline-block')
  button(:add_to_shopping_cart, id: 'add-to-cart-button')
  span(:cart_icon, id: 'nav-cart-count')
  button(:shopping_cart_link, id: 'nav-cart-count')
  link(:subsequent_item, class: 'a-link-normal')
  button(:checkout_button, id: 'sc-buy-box-ptc-button')
end