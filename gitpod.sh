#!/bin/bash

# Check if TEST_PATH is already set
if [ -z ${TEST_PATH+x} ]; then
    # TEST_PATH is not set, assign the default value
    TEST_PATH="/gitpod/desktop-browser"
fi

cd $TEST_PATH
bundle update --bundler
bundle install
bundle exec rspec
