require 'page-object'
require 'watir'

module Searching
  include PageObject::PageFactory

  def enter_search_term(search_term)
    on_page(Amazon).search_box = search_term
  end

  def click_on_search_button
    on_page(Amazon).search_button
  end

end