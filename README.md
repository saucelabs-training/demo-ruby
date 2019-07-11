# Ruby Selenium Examples

This directory contains example scripts and dependencies for running automated Selenium tests on Sauce Labs using **Ruby**. You can use these scripts to test your Sauce Labs authentication credentials, the setup of your automated testing environment, and try out Sauce Labs features, like cross-browser testing. Feel free to copy these files or clone the entire directory to your local environment to experiment with creating your own automated Selenium tests!

#### For Demonstration Purposes Only

The code in these scripts is provided on an "AS-IS” basis without warranty of any kind, either express or implied, including without limitation any implied warranties of condition, uninterrupted use, merchantability, fitness for a particular purpose, or non-infringement. These scripts are provided for educational and demonstration purposes only, and should not be used in production. Issues regarding these scripts should be submitted through GitHub. These scripts are maintained by the Technical Services team at Sauce Labs.

<br />

## Description

These procedures will show you to set up a Selenium environment for Ruby. The scripts in this repository allow you run a simple automated test to validate your Selenium environment and your [saucelabs.com](https://app.saucelabs.com/login) account credentials.

<br />

## Prerequisites

In order to complete these exercises you must complete the following prerequisite installation and configuration steps:

* Install Git
* Install `rbenv` and `ruby`
* Install an IDE (RubyMine, RadRails etc.)
* Configure `Gemfile`
* Setup Project

### Install Git

[Git](https://git-scm.com/doc) is a version control system that lets you check out code from a repository, 
work with that code on your own branch, and then merge that code with any changes that have been made by other developers. 
Git is an essential tool for distributed development teams, and is a critical component of the continuous 
integration/continuous development toolchain.

##### MacOSX:

1. Go to [https://git-scm.com/downloads](https://git-scm.com/downloads).
2. Under **Downloads**, click **Mac OS X**.
3. When the download completes, double-click the `.dmg` file open the installer package.
4. Double-click the installer package to begin the installation.
    > *Security Warning*
    >
    > You may see a warning message that the package can't be opened because it's not from a recognized developer. 
    If this happens, go to System Preferences > Security and Privacy Settings, and click Open Anyway.
5. Click **Continue** for the installation, and enter your local password to authorize the installation.

##### Windows:

1. Go to [https://git-scm.com/downloads](https://git-scm.com/downloads)
2. Under **Downloads**, click on **Windows**.
3. When the dialog opens asking if you want to allow the app to make changes to your device, click Yes.
4. Follow the steps in the setup wizard to complete the installation. You should accept all the default settings.
<br />

### Install Ruby
For Unix/Linux systems we use [rbenv](https://github.com/rbenv/rbenv). `rbenv` is a tool that lets you install, run, and manage multiple versions of `ruby` environments on your system.

##### MacOSX:
1. Using `brew` install `rbenv`:
   
    ```
    $ brew install rbenv
    ```
    
2. Setup `rbenv` in your current `bash` shell:
    
    ```
    $ rbenv init
    ```
    
3. Close and restart your terminal, or run the following command so changes take effect:
    
    ```
    $ source ~/.bashrc
    ``` 
    
4. Verify that `rbenv` is configured correctly, and running on your system:
    
    ```
    $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
    Checking for `rbenv' in PATH: /usr/local/bin/rbenv
    Checking for rbenv shims in PATH: OK
    Checking `rbenv install' support: /usr/local/bin/rbenv-install (ruby-build 20170523)
    Counting installed Ruby versions: none
      There aren't any Ruby versions installed under `~/.rbenv/versions'.
      You can install Ruby versions like so: rbenv install 2.2.4
    Checking RubyGems settings: OK
    Auditing installed plugins: OK
    ```
    
5. Install a version of Ruby using `rbenv`, here are [list of the available versions](https://github.com/rbenv/rbenv#installing-ruby-versions):
    
    ```
    $ rbenv install <ruby_version>
    ```
    
6. The `ruby` versions are generally stored in the following directory:
   
    ```
    ~/.rbenv/versions
    ```
    
##### Windows:
1. Go to [https://rubyinstaler.org/downloads/](https://rubyinstaller.org/downloads/).
2. Under **RubyInstallers**, choose the latest version of **Ruby+DevKit**.
3. Download the package and extract it on you system.
4. Open the executable and follow the prompts to complete installation.
4. To upgrade Ruby, use `ridk install` command.

    > This installer configures Ruby as a native Windows application, to learn more about RubyInstaller refer to the this [link](https://rubyinstaller.org/about/comparison/) 

### Install an IDE

It's recommended to install and Integrated Developer Environment, or a text editor, to help manage package dependencies, interperters, and overall code execution. There are several options available, some of them are free and some require payment:

* [Aptana Studio](hhttps://github.com/aptana/studio3) free, IDE developed by GitHub. There are versions for MacOSX, Windows, and Linux.
* [RubyMine](https://www.jetbrains.com/ruby/download/) free trial, paid after 30 days, developed by JetBrains.
* [Komodo Edit](https://www.activestate.com/komodo-edit), free, text editor, stripped down version of [Komodo IDE](https://www.activestate.com/products/komodo-ide/features/) (paid version).
* [NetBeans](https://netbeans.apache.org/download/index.html) free, open source IDE developed by Apache. Contains source binaries that you must download and compile.

### Setup the Project


1. Create a Project Directory:
    * Create a directory on your filesystem to store the project files. You can create the directory using the IDE toolbar or the command line. Below is an example of using the command line to create your project directory:

    ```
    $ mkdir ruby_tests
    ```
    
2. Setup `Gemfile`:
    * Install `bundler` so that we can easily update and resolve dependencies:
    
    ```
    $ gem install bundler
    ```
    
    * Create a `Gemfile` and enter the following `gems`:
    
    ```
    $ bundle init
    ```
    
    ```
    source 'https://rubygems.org'
    gem 'rspec'
    gem 'selenium-webdriver'
    gem 'sauce_whisk'
    gem 'rubocop' 
    ```
    
3. Execute the `bundle` Command:
    * Use the following to install the required `gems`:
    
        ```
        $ bundle install --path .bundle
        ```

4. Setup the `spec` Directory:
    * Tests written in `RSpec` (the testing framework used in this example), are called "specs" (short for specifications). 
    * Create a `spec` directory where we will store our tests:
    
        ```
        $ mkdir spec
        ```
        
    * Create a `.rb` file called `instant_sauce_rspec_test1.rb`, and copy and paste the contents from [https://github.com/saucelabs-training/demo-ruby/blob/master/spec/instant_sauce_test1_spec.rb](https://github.com/saucelabs-training/demo-ruby/blob/master/spec/instant_sauce_test1_spec.rb)
    
5. Run the Test Script
    * In order to run the test on [www.saucelabs.com](www.saucelabs.com), change the values of **`SAUCE_USERNAME`** and **`SAUCE_ACCESS_KEY`** in the following url:
    
        ```
        https://SAUCE_USERNAME:SAUCE_ACCESS_KEY@ondemand.saucelabs.com:443/wd/hub'
        ```
    > To retrieve this information, login to your saucelabs.com account and navigate to **User Settings**; there it displays your username and access key.
    
    * Run the following command to have `rspec`  search and executes 'specs' in your project directories:
    
        ```
        $ bundle exec rspec
    
        Finished in 0.00068 seconds (files took 0.30099 seconds to load)
        0 examples, 0 failures
        ```
    
    * You may also use 'Run Configurations' in your IDE. For directions on how to setup Run/Debug Configurations refer to Documentation:
        * [Aptana Studio Documentation](https://github.com/aptana/studio3-ruby)
        * [RubyMine Documentation](https://www.jetbrains.com/ruby/documentation/)
        * [Komodo Edit Documentation](http://docs.komodoide.com/manual)
        * [NetBeans Documentation](https://netbeans.org/kb/)
