
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

And..... That's it!

## That's not really it

No, it isn't.  This example isn't as simple as it could be, because it's intended to show how visual tests can be cleanly added to a standard RSpec suite.

Here's some of the interesting points.

### spec/visual_helper.rb

This is where most of our integration code lives.  This gets included at the bottom of out `spec_helper`, so that most of our RSpec setup is done: `require_relative "visual_helper"`.

Most of this file is dedicated to a shared context that defines some helper methods, setup and teardown of visual tests.

### Example Metadata
This example will only conduct a visual test for examples & example groups tagged `:visual`. Tagged examples have the shared context included by a small amount of RSpec configuration:

```ruby
RSpec.configure do |rspec|
	rspec.include_context "visual testing", :visual #<- Change me to change the tag
end
```

### Taking Snapshots
Within a visual example, you can take a screenshot by calling the `visual_snapshot` method with the snapshot name:  `visual_snapshot "Australian Themed Checkout"`.

### Naming Snapshots
Snapshots are organized into tests, named after  your tests will be named after your `describe` blocks, taking into account any nesting:

```ruby
RSpec.describe "Visual E2E", :visual do
	it "Is a great way to check CSS" do

	#Test name: "Visual E2E"

RSpec.describe "Visual E2E" do
	context "When in a nest" do
		it "Still makes checking CSS good" do

		#Test name: "Visual E2E @When in a nest"
```
You can override by passing a string to the `:visual` tag:

```ruby
RSpec.describe "Visual E2E", :visual => "Sauce Tests" do
	it "Is a great way to check CSS" do

	#Test name: "Sauce Tests"
```
