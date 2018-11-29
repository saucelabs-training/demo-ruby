require 'rspec/core/rake_task'

ENV['PARALLEL_SPLIT_TEST_PROCESSES'] = '10'

# TODO - add in windows_8_ie once Sample App is fixed
PLATFORMS = %w[windows_10_edge mac_sierra_chrome windows_7_ff]

PLATFORMS.each do |platform|
  desc "Run tests in parallel within suite using #{platform}"
  task platform do
    ENV['PLATFORM'] = platform
    system 'parallel_split_test spec'
  end
end

task :default do
  Rake::Task[PLATFORMS.first].execute
end


#
# For Running Sauce Demo
#

@success = true

PLATFORMS.each do |platform|
  task "#{platform}_demo" do
    ENV['PLATFORM'] = platform
    begin
      @result = system 'parallel_split_test spec'
    ensure
      @success &= @result
    end
  end
end

desc "Run multiple platforms simultaneously"
multitask sauce_demo: PLATFORMS.map { |p| "#{p}_demo" } do
  begin
    raise StandardError, "Tests failed!" unless @success
  ensure
    @success &= @result
  end
end
