require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

task default: :test_sauce

task :parallel_run do
  system 'parallel_rspec spec'
end

task :windows_8_1_chrome_43 do
  ENV['platform'] = 'Windows 8.1'
  ENV['browserName'] = 'chrome'
  ENV['version'] = '43'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_8_1_chrome_43'
  Rake::Task[:parallel_run].execute
end

task :windows_7_firefox_40 do
  ENV['platform'] = 'Windows 7'
  ENV['browserName'] = 'firefox'
  ENV['version'] = '40'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_7_firefox40'
  Rake::Task[:parallel_run].execute
end

task :os_x_10_9_chrome_45 do
  ENV['platform'] = 'OS X 10.9'
  ENV['browserName'] = 'chrome'
  ENV['version'] = '45'
  ENV['JUNIT_DIR'] = 'junit_reports/os_x_10_9_chrome_45'
  Rake::Task[:parallel_run].execute
end

task :windows_xp_firefox_39 do
  ENV['platform'] = 'Windows XP'
  ENV['browserName'] = 'firefox'
  ENV['version'] = '39'
  ENV['JUNIT_DIR'] = 'junit_reports/windows_xp_firefox_39'
  Rake::Task[:parallel_run].execute
end

multitask :test_sauce => [
    :windows_8_1_chrome_43,
    :windows_7_firefox_40,
    :os_x_10_9_chrome_45,
    :windows_xp_firefox_39
] do
  puts 'Running automation'
end
