require 'page-object'
require 'watir'

module ShoppingCart
  include PageObject::PageFactory

  def add_to_cart
    on_page(Amazon).add_to_shopping_cart
  end

  def add_watership_down_to_cart
    on_page(WatershipDown).add_to_cart
  end

end