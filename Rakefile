@success = true

def run_tests(platform, browser, version, junit_dir)
  sh("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" parallel_cucumber features -o \"--format junit --out #{junit_dir} --format pretty\" -n 20") do | success, exit_code |
    @success &= success
  end
end

task :default => [:test_sauce]

task :windows_10_edge_14 do
  run_tests('Windows 10', 'edge', '14.14393', 'junit_reports/windows_10_edge_14')
end

task :windows_10_chrome_54 do
  run_tests('Windows 10', 'chrome', '54.0', 'junit_reports/windows_10_chrome_54')
end

task :windows_7_ie_11 do
  run_tests('Windows 7', 'internet_explorer', '11.0', 'junit_reports/windows_7_ie_11')
end

task :os_x_10_11_safari_10 do
  run_tests('OS X 10.11', 'safari', '10.0', 'junit_reports/os_x_10_11_safari_10')
end

task :os_x_10_10_firefox_49 do
  run_tests('OS X 10.10', 'firefox', '49.0', 'junit_reports/os_x_10_10_firefox_49')
end

multitask :test_sauce => [
    :windows_10_edge_14,
    :windows_10_chrome_54,
    :windows_7_ie_11,
    :os_x_10_11_safari_10,
    :os_x_10_10_firefox_49
  ] do
    raise StandardError, "Tests failed!" if not @success
  end
