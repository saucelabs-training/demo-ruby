require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

task default: :test_sauce

task :parallel_run do
  system 'parallel_rspec spec'
end

task :windows_10_edge_14 do
  ENV['platform'] = 'Windows 10'
  ENV['browserName'] = 'edge'
  ENV['version'] = '14.14393'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_10_edge_14'

  Rake::Task[:parallel_run].execute
end

task :windows_10_firefox_49 do
  ENV['platform'] = 'Windows 10'
  ENV['browserName'] = 'firefox'
  ENV['version'] = '49.0'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_10_firefox_49'

  Rake::Task[:parallel_run].execute
end

task :windows_7_ie_11 do
  ENV['platform'] = 'Windows 7'
  ENV['browserName'] = 'internet_explorer'
  ENV['version'] = '11.0'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_7_ie_11'

  Rake::Task[:parallel_run].execute
end

task :os_x_10_11_safari_10 do
  ENV['platform'] = 'OS X 10.11'
  ENV['browserName'] = 'safari'
  ENV['version'] = '10.0'
  ENV['JUNIT_DIR'] = 'junit_reports/os_x_10_11_safari_10'

  Rake::Task[:parallel_run].execute
end

task :os_x_10_10_chrome_54 do
  ENV['platform'] = 'OS X 10.10'
  ENV['browserName'] = 'chrome'
  ENV['version'] = '54.0'
  ENV['JUNIT_DIR'] = 'junit_reports/os_x_10_10_chrome_54'

  Rake::Task[:parallel_run].execute
end

multitask :test_sauce => [
    :windows_10_edge_14,
    :windows_10_firefox_49,
    :windows_7_ie_11,
    :os_x_10_11_safari_10,
    :os_x_10_10_chrome_54
] do
  puts 'Running automation'
end
