require 'fileutils'

features_folder = ARGV[0]
destination_folder = ARGV[1]

files = []

Dir[File.join(features_folder, '**', '*.feature')].keep_if do | file, value |
  files << file if File.file?(file)
  content = File.read file

  # require 'debugger'; debugger;
  split_arr  = content.split(/((?:[\s]*@.*)?[\n ]*Scenario.*)/)

  scenario_name_line_num = 1
  total_lines_num = split_arr.size

  feature_text = split_arr[0]

  new_file_number = 1
  while scenario_name_line_num < total_lines_num  do
      scenario_name = split_arr[scenario_name_line_num]
      scenario = split_arr[scenario_name_line_num + 1]

      newFile = File.join(destination_folder, file.gsub("#{features_folder}/", ""))
      newFile = newFile.gsub(".feature", "_#{new_file_number}.feature") if total_lines_num > 3

      dirname = File.dirname(newFile)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      puts "Creating #{newFile}"

      File.open(newFile, 'w') { |f|
      	f.puts feature_text + scenario_name + scenario
         # + "\n" + scenario_name + scenario
      }

      new_file_number += 1
      scenario_name_line_num += 2
    end

  end

# TO DO: Write logic to carry over tags and background
