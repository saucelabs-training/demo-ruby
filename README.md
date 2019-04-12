## Ruby-RSpec-Capybara
[![Travis Status](https://travis-ci.org/saucelabs-sample-test-frameworks/Ruby-RSpec-Capybara.svg?branch=master)](https://travis-ci.org/saucelabs-sample-test-frameworks/Ruby-RSpec-Capybara)

### Environment Setup

1. Global Dependencies
    * [Install Ruby](http://watir.com/guides/ruby/)
    * [Install Git](https://github.com/address-book/junit_tests#install-git)
    * Clone This Repo
    ```
    $ git clone ruby-rspec-capybara https://github.com/saucelabs-sample-test-frameworks/Ruby-RSpec-Capybara.git
    ```
    * Install bundler
    ```
    $ gem install bundler
    ```

2. Sauce Credentials
    * In the terminal export your Sauce Labs Credentials as environmental variables:
    ```
    $ export SAUCE_USERNAME=<your Sauce Labs username>
    $ export SAUCE_ACCESS_KEY=<your Sauce Labs access key>
    ```

3. Project Dependencies
	* Install packages
	```
	$ bundle install
	```

### Running Tests

* Run tests in parallel on default configuration:
	```
	$ bundle exec rake
	```
* Run in parallel on a specified configuration (see `/spec/Rakefile` for the available tasks)
	```
	$ bundle exec rake windows_10_edge
	```
* Demo Mode
	```
	$ bundle exec rake sauce_demo
	```

### Watch Your Tests Run

[Sauce Labs Dashboard](https://app.saucelabs.com/dashboard)
