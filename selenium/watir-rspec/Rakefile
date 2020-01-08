# frozen_string_literal: true

require 'rspec/core/rake_task'

#
# For use in building a unique Build Name for Sauce Labs
#
ENV['SAUCE_START_TIME'] = "Ruby-RSpec-Selenium: Local-#{Time.now.to_i}"

#
# Uses parallel-split-test gem to set the number of tests that get run in parallel
# parallel_split_test gem splits up tests within files
#
ENV['PARALLEL_SPLIT_TEST_PROCESSES'] = '10'

#
# Ideally run one of these Rake Tasks in your CI rather than
# setting the 2 ENV variables and executing this command
#
desc 'Run tests in parallel within suite using Windows 10 with Edge'
task :windows_10_edge do
  ENV['PLATFORM'] = 'windows_10_edge'
  system 'parallel_split_test spec'
end

desc 'Run tests in parallel within suite using Mac Sierra with Chrome'
task :mac_sierra_chrome do
  ENV['PLATFORM'] = 'mac_sierra_chrome'
  system 'parallel_split_test spec'
end

desc 'Run tests in parallel within suite using Windows 7 with Firefox'
task :windows_7_ff do
  ENV['PLATFORM'] = 'windows_7_ff'
  system 'parallel_split_test spec'
end

desc 'Run tests in parallel within suite using Windows 8 with Internet Explorer'
task :windows_8_ie do
  ENV['PLATFORM'] = 'windows_8_ie'
  system 'parallel_split_test spec'
end

desc 'Run tests in parallel within suite using Mac Mojave with Safari'
task :mac_mojave_safari do
  ENV['PLATFORM'] = 'mac_mojave_safari'
  system 'parallel_split_test spec'
end

desc 'Run tests in parallel within suite using Mac Mojave with Safari'
task :headless do
  ENV['PLATFORM'] = 'headless'
  system 'parallel_split_test spec'
end

#
# Always set a Default Task
#
task :default do
  Rake::Task[:mac_sierra_chrome].execute
end

#
# For Running Sauce Demo
# This runs multiple platforms at the same time, which isn't considered best practice,
# but is useful for demonstrating Sauce Labs features
#

@success = true

PLATFORMS = %w[windows_10_edge mac_sierra_chrome windows_7_ff windows_8_ie mac_mojave_safari].freeze

PLATFORMS.each do |platform|
  task "#{platform}_demo" do
    ENV['PLATFORM'] = platform
    ENV['PARALLEL_SPLIT_TEST_PROCESSES'] = '2'
    begin
      @result = system 'parallel_split_test spec'
    ensure
      @success &= @result
    end
  end
end

desc 'Sauce Labs Demo to run multiple platforms simultaneously'
multitask sauce_demo: PLATFORMS.map { |p| "#{p}_demo" } do
  begin
    raise StandardError, 'Tests failed!' unless @success
  ensure
    @success &= @result
  end
end
