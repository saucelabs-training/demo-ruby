# Ruby Demonstration Scripts

[![CircleCI](https://circleci.com/gh/saucelabs-training/demo-ruby.svg?style=svg)](https://circleci.com/gh/saucelabs-training/demo-ruby)

The demo scripts in [this repository](https://github.com/saucelabs-training/demo-ruby) allow you to run simple automated tests in order to validate your Ruby testing environment and your [saucelabs.com](https://app.saucelabs.com/login) account credentials.

> ###### Disclaimer:
> The code in these scripts is provided on an "AS-IS" basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. These scripts are provided for educational and demonstration purposes only, and should not be used in production. Issues regarding these scripts should be submitted through GitHub. These scripts are maintained by the Technical Services team at Sauce Labs.

<br />

## Prerequisites

In order to complete these exercises you must complete the following prerequisite installation and configuration steps:

* Install [Git](https://github.com/saucelabs-training/demo-ruby/blob/master/docs/prerequisites.md#install-git)
* Install [Ruby](https://github.com/saucelabs-training/demo-ruby/blob/master/docs/prerequisites.md#install-ruby)
* Install an [IDE (RubyMine, RadRails etc.)]((https://github.com/saucelabs-training/demo-ruby/blob/master/docs/prerequisites.md#install-an-ide)
* [Setup the Project](#setup-the-project)

> Select the button below to try this demo in [Gitpod](https://www.gitpod.io/)
>
> <a href="https://gitpod.io/#https://github.com/saucelabs-training/demo-ruby"><img src="https://github.com/saucelabs-training/demo-ruby/blob/master/docs/open-in-gitpod.png" title="Open in Gitpod"></a>
>
> [Click here](docs/gitpod_instructions.md) to see how to setup your Sauce Labs credentials in Gitpod

<br />

### Setup the Project
 
1. Setup `Gemfile`:
    * Install `bundler` so that we can easily update and resolve dependencies:
    
        ```
        $ gem install bundler
        ```

2. Execute the `bundle` Command:
    * Use the following to install the required `gems`:
    
        ```
        $ bundle install --path .bundle
        ```

    
3. Run the Test Scripts
    * In order to run the tests on [www.saucelabs.com](www.saucelabs.com), you need to [export your Sauce Labs account credentials as environment variables](https://wiki.saucelabs.com/display/DOCS/Best+Practice%3A+Use+Environment+Variables+for+Authentication+Credentials), or hard code (not recommended) the values of **`SAUCE_USERNAME`** and **`SAUCE_ACCESS_KEY`** in each script. For example:
    
        ```
        https://SAUCE_USERNAME:SAUCE_ACCESS_KEY@ondemand.saucelabs.com:443/wd/hub'
        ```
    
    * Run the following command to have `rspec`  search and execute 'specs' in your project directories:
    
        ```
        $ bundle exec rspec
        ```
    
    * You may also use 'Run Configurations' in your IDE. For directions on how to setup Run/Debug Configurations refer to Documentation:
        * [Aptana Studio Documentation](https://github.com/aptana/studio3-ruby)
        * [RubyMine Documentation](https://www.jetbrains.com/ruby/documentation/)
        * [Komodo Edit Documentation](http://docs.komodoide.com/manual)
        * [NetBeans Documentation](https://netbeans.org/kb/)
