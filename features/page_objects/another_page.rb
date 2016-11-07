class AnotherPage
  def initialize(browser)
    @browser = browser
  end

  def title
    @browser.title
  end

  def on_page?
    @browser.title == "I am another page title - Sauce Labs"
  end
end
