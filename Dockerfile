FROM ruby:3
COPY . .
RUN BUNDLE_GEMFILE='./training-sessions/intro/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./training-sessions/selenium4/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./sauce-features/visual/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./sauce-features/accessibility/Gemfile' bundle install
#RUN BUNDLE_GEMFILE='./selenium-examples/capybara-rspec/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./selenium-examples/cucumber/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./selenium-examples/watir-rspec/Gemfile' bundle install
#RUN BUNDLE_GEMFILE='./selenium-examples/capybara-cucumber/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./selenium-examples/rspec/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./selenium-examples/watir-cucumber/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./appium-examples/Cucumber/emusim/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./appium-examples/RSpec/emusim/Gemfile' bundle install
RUN BUNDLE_GEMFILE='./appium-examples/RSpec/rdc/Gemfile' bundle install
CMD [""]
