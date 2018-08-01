require 'page-object'
require 'watir'

module Navigation
  include PageObject::PageFactory

  def goto_amazon
    visit_page(Amazon)
  end

  def choose_item
    on_page(Amazon).first_item
  end

  def choose_subsequent_item
    on_page(Amazon).subsequent_item
  end

  def navigate_to_shopping_cart
    on_page(Amazon).shopping_cart_link
  end

  def checkout
    on_page(Amazon).checkout_button
  end

  def goto_watership_down
    visit_page(WatershipDown)
  end

  def goto_devops_handbook
    visit_page(DevOpsHandbook)
  end

  def goto_clean_code
    visit_page(CleanCode)
  end

  def goto_phoenix_project
    visit_page(PhoenixProject)
  end

  def goto_sword_of_shannara
    visit_page(SwordOfShannara)
  end

end