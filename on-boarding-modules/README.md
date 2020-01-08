# Sauce Labs On-Boarding JavaScript Examples

The following scripts provide quick examples to test your connection to Sauce Labs. Each script, titled `module<#>-<framework_name>`, represents a module from the "Getting Started" tab in the Sauce labs UI.

### Module List

* [Module 1: Running your first test](#module-1-running-your-first-test)
* [Module 2: Testing against your own application](#module-2-testing-against-your-own-application)
* [Module 3: Adding setup and teardown steps](#module-3-adding-setup-and-teardown-steps)
* [Module 4: Adjusting timeouts, delays, and build tags](#module-4-adjusting-timeouts-delays-and-build-tags)

<br />

> All examples below use the RSpec framework
>

### Module 1: Running your first test

Open the script `module1_<framework_name>_spec.rb`, and ensure you've exported (or hardcoded, but not recommended) your [Sauce Labs Account Credentials](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Environment+Variables+for+Authentication+Credentials) in the following placeholder:

```
username = ENV.SAUCE_USERNAME
access_key = ENV.SAUCE_ACCESS_KEY
```

Run the following command to run the test:

```
exec rspec module1-<framework_name>_spec.rb
```

<br />

### Module 2: Testing against your own application

Open the script `module2_<framework_name>_spec.rb`. Edit the following line with your own application URL:

```
driver.get('https://www.saucedemo.com'),
```

Please take notice that if your application is not publicly available the test will fail to make a connection with Sauce Labs. Please read the following wiki page on how to [Setup Sauce Connect Proxy](https://wiki.saucelabs.com/display/DOCS/Sauce+Connect+Proxy) to ensure you're tests can run on Sauce Labs.

<br />

### Module 3: Adding `setup` and `teardown` Steps

Open the script `module3_<framework_name>_spec.rb`. Please notice how the script contains ` before` and ` after` methods.

`before`:
```
before(:each) do |test|
    caps = {
        browser_name: 'chrome',
        # platform_version now becomes platform_name with the W3C bridge.
        # For more details see: https://www.rubydoc.info/gems/selenium-webdriver/Selenium/WebDriver/Remote/W3C/Capabilities
        platform_name: 'windows 10',
        browser_version: 'latest',
        # use sauce:options to handle all saucelabs.com-specific capabilities such as:
        # username, accesskey, build number, test name, timeouts etc.
        "sauce:options" => {
            build: 'Onboarding Sample App - Ruby',
            name: '3-cross-browser',
            seleniumVersion: '3.141.59',
            username: ENV['SAUCE_USERNAME'],
            accessKey: ENV['SAUCE_ACCESS_KEY']
        }
    }
    @driver = Selenium::WebDriver.for(:remote,
                                      url: 'https://ondemand.saucelabs.com:443/wd/hub',
                                      desired_capabilities: caps)
  end
```

`after:`
```
after(:each) do |example|
    # SauceWhisk::Jobs is a Ruby wrapper for the SauceLabs REST API. Here we're updating the job method
    # For more info please visit the Sauce Labs REST API Documentation: https://wiki.saucelabs.com/display/DOCS/Job+Methods
    SauceWhisk::Jobs.change_status(@driver.session_id, !example.exception)
    @driver.quit
  end
```

This follows the automated testing best practice of setting prerequisite and postrequisite tasks for each test suite. 

In this example, we move our setup tasks (setting test capability options) and our teardown tasks (closing the Sauce Labs session and returning the test result) into separate methods.

<br />

### Module 4: Adjusting timeouts, delays, and build tags

Open the script `module4_<framework_name>_spec.rb`. Please notice that the following lines contain some specific `driver` capabilities:

```
tags: ['instant-sauce', 'ruby-rspec', 'module4'],
maxDuration: 1800,
commandTimeout: 300,
idleTimeout: 1000
```

These test configuration options, allow you to control how long a session will wait for a new test command (`idleTimeout`), the maximum duration for the Sauce Labs VM lifecycle  (`maxDuration`), and the ability to filter test results by specific keywords (`tags`). 

Please read the following wiki page to learn more about [setting build tags](https://wiki.saucelabs.com/display/DOCSDEV/Best+Practice%3A+Use+Build+IDs%2C+Tags%2C+and+Names+to+Identify+Your+Tests) and [controlling build timeouts](https://wiki.saucelabs.com/display/DOCS/Test+Configuration+Options#TestConfigurationOptions-MaximumTestDuration).