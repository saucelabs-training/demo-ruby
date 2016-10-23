@success = true

def run_tests(platform, browser, version, junit_dir)
  @success &= system("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" parallel_cucumber features -o \"--format junit --out #{junit_dir} --format pretty\" -n 20")
end

task :default => [:test_sauce]

# Windows 8.1, Chrome 43
task :windows_8_1_chrome_43 do
  run_tests('Windows 8.1', 'chrome', '43', 'junit_reports/windows_8_1_chrome_43')
end

# Windows 7, Firefox 40
task :windows_7_firefox_40 do
  run_tests('Windows 7', 'firefox', '40', 'junit_reports/windows_7_firefox40')
end

# OS X 10.9 Chrome 45
task :os_x_10_9_safari_7 do
  run_tests('OS X 10.9', 'safari', '7', 'junit_reports/os_x_10_9_safari_7')
end

# Windows XP Firefox 39
task :windows_xp_firefox_39 do
  run_tests('Windows XP', 'firefox', '39', 'junit_reports/windows_xp_firefox_39')
end

# Task to run all the above configurations in parallel
multitask :test_sauce => [
    :windows_8_1_chrome_43,
    :windows_7_firefox_40,
    :os_x_10_9_safari_7,
    :windows_xp_firefox_39
  ] do
    raise "Tests failed!" unless @success
end
