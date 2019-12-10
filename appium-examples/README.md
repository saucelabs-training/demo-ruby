## Ruby Appium Example Scripts

These demonstration scripts allow you to run an automated Appium tests on Sauce Labs platforms.

> ###### Disclaimer:
> The code in these scripts is provided on an "AS-IS" basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. These scripts are provided for educational and demonstration purposes only, and should not be used in production. Issues regarding these scripts should be submitted through GitHub. These scripts are maintained by the Technical Services team at Sauce Labs.
>
> Some examples in this repository, such as `appium-examples` and `headless-examples`, may require a different account tier beyond free trial. Please contact the [Sauce Labs Sales Team](https://saucelabs.com/contact) for support and information.

<br />

### Prerequisites

* Install [ruby](https://www.ruby-lang.org/en/documentation/installation/)
* Install [rake](http://docs.seattlerb.org/rake/)

### Environment Setup

1. Set Global Dependencies
    * Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
    * Or Install Ruby with [Homebrew](http://brew.sh/)
    ```
    $ brew install ruby
    ```
    * Install [Rake](http://docs.seattlerb.org/rake/)
    ```
    $ gem install rake
    ```
    * Install bundler (Sudo may be necessary)
    ```
    $ gem install bundler
    ```

2. Set Sauce Credentials
    * In the terminal [export your Sauce Labs Credentials as environmental variables](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Environment+Variables+for+Authentication+Credentials):
    ```
    $ export SAUCE_USERNAME=<your Sauce Labs username>
    $ export SAUCE_ACCESS_KEY=<your Sauce Labs access key>
    ```
3. Set Project Dependencies
	* Install packages (Use sudo if necessary)
	```
	$ bundle install
	```
 
 <br />
 
### Running the Tests

1. Choose and navigate to the desired test framework:
    * `RSpec`
    * `Cucumber`
2. Navigate to the desired directory:
    * for running tests on emulators and simulators: `emusim`
    * for running tests on real devices: `rdc`
3. Navigate to either the `android` or `ios` directory.
4. Run the following command to run tests in Parallel:
	```
	$ rake test_sauce
	```
5. Visit the [Sauce Labs Dashboard](https://saucelabs.com/beta/dashboard/) to see the results.

<br />

### Advice and Troubleshooting

There may be additional latency when using a remote webdriver to run tests on Sauce Labs, therefore timeouts or "Waits" may need to be increased. Please read the following wiki page on [tips regarding explicit waits](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Explicit+Waits)

<br />

##### More Information
* [Sauce Labs Documentation](https://wiki.saucelabs.com/)
* [Appium Documentation](http://appium.io/slate/en/master/)
* [RSpec Documentation](http://rspec.info/documentation/)
* [Ruby Documentation](http://ruby-doc.org/)