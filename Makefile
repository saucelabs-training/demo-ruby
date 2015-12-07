JUNIT_DIR?=junit_reports
FEATURES_DIR?=features
SPLIT_FEATUERS_DIR?=split_features


run_all_in_parallel:
	make -j test_Windows_10_microsoftedge_20 test_XP_chrome_43 test_Windows7_firefox_33 test_OSX10.10_safari_8

run_all_in_full_parallel:
	make split_scenarios && FEATURES_DIR=split_features make run_all_in_parallel

test_Windows_10_microsoftedge_20:
	platform="Windows 10" browserName="microsoftedge" version="20" JUNIT_DIR=junit_reports/test_Windows_10_microsoftedge_20 make parallel_cucumber

test_XP_chrome_43:
	platform=XP browserName=chrome version=43 \
		JUNIT_DIR=junit_reports/test_XP_chrome_43 \
		make parallel_cucumber

test_OSX10.10_safari_8:
	platform="OS X 10.10" browserName=safari version=8 \
		JUNIT_DIR=junit_reports/test_OSX10.10_safari_8 \
		make parallel_cucumber

test_Windows7_firefox_33:
	platform="Windows 7" browserName=firefox version=33 \
		JUNIT_DIR=junit_reports/test_Windows7_firefox_33 \
		make parallel_cucumber

parallel_cucumber:
	-rm -rf $(JUNIT_DIR)
	parallel_cucumber $(FEATURES_DIR) -o "--format junit --out $(JUNIT_DIR) --format pretty" -n 20

split_scenarios:
	-rm -rf $(SPLIT_FEATUERS_DIR)
	ruby utils/scenario_splitter.rb $(FEATURES_DIR) $(SPLIT_FEATUERS_DIR)
