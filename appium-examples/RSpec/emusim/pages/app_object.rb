require_relative "../spec/pec/spec_helper"

class GuineaPigAppPage
  attr_accessor :driver
  def initialize(driver)
    @driver = driver
  end

  # Elements

  def textInput
    @driver.find_element(:id, "i_am_a_textbox")
  end

  def emailTextInput
    @driver.find_element(:id, "fbemail")
  end

end