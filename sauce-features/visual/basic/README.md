
# Visual Testing with Sauce Labs & RSpec

## Running the Example
### Pre-requisites
1. An enterprise grade Sauce Labs account
2. Access to the Sauce Visual E2E product; Ask your CSM!
3. A Sane Ruby environment with bundler installed

### Getting Started
1. Set the `SAUCE_USERNAME`, `SAUCE_ACCESS_KEY` and `SCREENER_API_KEY` environment variables
2. Install dependencies:

`$ bundle install`

### Running The Example
1. Execute RSpec from the project's root directory:

`$ bundle exec rspec`

If all goes well, all will not go well; You'll see a test failure because your brand new snapshot isn't accepted yet.
For more information about the State workflow, see the Visual Testing documentation.
