require 'rspec/core/rake_task'
@success = true

%w[windows_10_edge windows_8_ie mac_sierra_chrome windows_7_ff].each do |platform|
  desc "Run tests in parallel within suite using #{platform}"
  task platform.to_s do
    ENV['PLATFORM'] = platform
    Rake::Task[:parallel_run].execute
  end
end

desc "Run tests in parallel within suite using default platform"
task :parallel_run do
  begin
    @result = system "parallel_cucumber features/ -n 10"
  ensure
    @success &= @result
  end
end

desc "Run multiple platforms simultaneously"
# TODO - add in windows_8_ie once Sample App is fixed
multitask sauce_demo: %w[windows_10_edge mac_sierra_chrome windows_7_ff] do
  begin
    raise StandardError, "Tests failed!" unless @success
  ensure
    @success &= @result
  end
end
