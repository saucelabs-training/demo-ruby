require 'json'

browserConfigs = JSON.parse(ENV["SAUCE_ONDEMAND_BROWSERS"])

file_to_write = ARGV[0]
raise 'error no file write to is specified' if file_to_write.nil?

config = []
content = ""
for browserConfig in browserConfigs
	s = "#{browserConfig["os"]}_#{browserConfig["browser"]}_#{browserConfig["browser-version"]}".gsub(' ', '_')
	config.push(s)
end

# create makefile master target

content << 'JUNIT_DIR?=junit_reports' + "\n\n"
content << "run_all:\n"
content << "\tmake -j #{config.join(' ')}\n\n"

i = 0
for browserConfig in browserConfigs
	content << "#{config[i]}:\n"
	content << "\tplatform=\"#{browserConfig['os']}\" browserName=\"#{browserConfig['browser']}\" version=\"#{browserConfig['browser-version']}\" JUNIT_DIR=junit_reports/test_#{config[i]} make parallel_cucumber\n\n"

	i = i +1
end

content << "parallel_cucumber:\n"
content << "\t-rm -rf $(JUNIT_DIR)\n"
content << "\tbundle exec parallel_cucumber features -o \"--format junit --out $(JUNIT_DIR) --format pretty\" -n 20\n"

puts content

File.write(file_to_write, content)