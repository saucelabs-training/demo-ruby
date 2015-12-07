def run_tests(platform, browser, version, junit_dir)
  system("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" JUNIT_DIR=\"#{junit_dir}\" parallel_split_test spec")
end

task :windows_8_1_chrome_43 do
  run_tests('Windows 8.1', 'chrome', '43', 'junit_reports/windows_8_1_chrome_43')
end

task :windows_7_firefox_40 do
  run_tests('Windows 7', 'firefox', '40', 'junit_reports/windows_7_firefox40')
end

task :os_x_10_9_chrome_45 do
  run_tests('OS X 10.9', 'chrome', '45', 'junit_reports/os_x_10_9_chrome_45')
end

task :windows_xp_firefox_39 do
  run_tests('Windows XP', 'firefox', '39', 'junit_reports/windows_xp_firefox_39')
end

multitask :test_sauce => [
    :windows_8_1_chrome_43,
    :windows_7_firefox_40,
    :os_x_10_9_chrome_45,
    :windows_xp_firefox_39
  ] do
    puts 'Running automation'
end

