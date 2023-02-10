FROM ruby:3
COPY './training-sessions/intro/Gemfile' './training-sessions/intro/'
COPY './training-sessions/selenium4/Gemfile' './training-sessions/selenium4/Gemfile.lock' './training-sessions/selenium4/'
COPY './sauce-features/visual/Gemfile' './sauce-features/visual/'
COPY './sauce-features/accessibility/Gemfile' './sauce-features/accessibility/'
#COPY './selenium-examples/capybara-rspec/Gemfile' './selenium-examples/capybara-rspec/Gemfile.lock' './'
COPY './selenium-examples/cucumber/Gemfile' './selenium-examples/cucumber/Gemfile.lock' './selenium-examples/cucumber/'
COPY './selenium-examples/watir-rspec/Gemfile' './selenium-examples/watir-rspec/Gemfile.lock' './selenium-examples/watir-rspec/'
#COPY './selenium-examples/capybara-cucumber/Gemfile' './selenium-examples/capybara-cucumber/Gemfile.lock' './'
COPY './selenium-examples/rspec/Gemfile' './selenium-examples/rspec/Gemfile.lock' './selenium-examples/rspec/'
COPY './selenium-examples/watir-cucumber/Gemfile' './selenium-examples/watir-cucumber/Gemfile.lock' './selenium-examples/watir-cucumber/'
COPY './appium-examples/Cucumber/emusim/Gemfile' './appium-examples/Cucumber/emusim/'
COPY './appium-examples/RSpec/emusim/Gemfile' './appium-examples/RSpec/emusim/Gemfile.lock' './appium-examples/RSpec/emusim/'
COPY './appium-examples/RSpec/rdc/Gemfile' './appium-examples/RSpec/rdc/Gemfile.lock' './appium-examples/RSpec/rdc/'
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
COPY . .
CMD [""]
