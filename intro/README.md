# A Technical Introduction to Sauce Labs for Non-Technical Users

### Executing a Job on Sauce Labs

1. [Sign up for a Sauce Labs Account](https://saucelabs.com/sign-up)
2. [Sign up for a Github account](https://github.com/join)
3. [Open the Gitpod](https://gitpod.io/#https://github.com/sauce-examples/ruby-example)
4. Sign in to Github if necessary to access Gitpod
5. Open `open_browser.rb` file
6. Locate your [Sauce Labs Credentials](https://app.saucelabs.com/user-settings)
7. Paste the credentials where it says "<SAUCE_USERNAME>" and "<SAUCE_ACCESS_KEY>"
8. Use the [Platform Configurator](https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/) to create your desired combination
9. Click the "Ruby" tab at the bottom of the page
10. Copy/Paste the "capabilities" code over the `capabilities: {}` line
11. In the terminal at the bottom, type: `ruby open_browser.rb` and hit enter
12. [Look at the job on the Dashboard](https://app.saucelabs.com/dashboard/tests)

### Adding Sauce Labs Settings

1. Look at the [Test Configuration Options](https://docs.saucelabs.com/reference/test-configuration/) for setting Sauce Labs specific values
2. Open `sauce_info.rb` file
3. Add a test name and build name (`name` and `build` respectively)
4. Set `extendedDebugging: true` and `capturePerformance: true`
5. Add code to report results to Sauce Labs
6. In the terminal, run: `ruby sauce_info.rb`
7. [Look at the job on the Dashboard](https://app.saucelabs.com/dashboard/tests)

### Running Real Tests

1. Open `spec/spec_helper.rb` file
2. Copy the setup code you used in `sauce_info.rb` into the "before" hook
3. Navigate to https://www.saucedemo.com/
4. Get the element information for username field, password field, and login button
5. Open `spec/passing_test_spec.rb` file
6. Write the selenium code for logging in with `standard_user`
7. Add code to verify resulting URL is correct
8. Open `spec/failing_test_spec.rb` file
9. Copy the code from `spec/passing_test_spec.rb` but changed the user name to `locked_out_user`
10. In the terminal, run `bundle exec rake`
11. [Look at the tests on the Dashboard](https://app.saucelabs.com/dashboard/tests)
