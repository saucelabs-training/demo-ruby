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