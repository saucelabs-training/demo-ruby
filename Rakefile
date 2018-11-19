require 'rspec/core/rake_task'

# TODO - add in windows_8_ie once Sample App is fixed
PLATFORMS = %w[windows_10_edge mac_sierra_chrome windows_7_ff]

PLATFORMS.each do |platform|
  desc "Run tests in parallel within suite using #{platform}"
  task platform.to_s do
    ENV['PLATFORM'] = platform
    system "parallel_cucumber features/ -n 10 --group-by scenarios"
  end
end

task :default do
  Rake::Task[:mac_sierra_chrome].execute
end


#
# For Running Sauce Demo
#

@success = true

PLATFORMS.each do |platform|
  task "#{platform}_demo" do
    ENV['PLATFORM'] = platform
    begin
      @result = system "parallel_cucumber features/ -n 10 --group-by scenarios"
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
