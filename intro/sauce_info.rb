require 'selenium-webdriver'

sauce_username = "<SAUCE_USERNAME>"
sauce_access_key = "<SAUCE_ACCESS_KEY>"
sauce_url = "https://" + sauce_username + ":" + sauce_access_key + "@ondemand.saucelabs.com:443/wd/hub"

sauce_info = {}

capabilities = {}

driver = Selenium::WebDriver.for :remote,
                                 url: sauce_url,
                                 desired_capabilities: capabilities

driver.execute_script("sauce:job-result=passed")

driver.quit
