# SETUP:
get :
	dart pub get

setup_coverage :
	dart pub global activate coverage


# TESTS:

tests : 
	dart run test --coverage=./coverage


# TEST COVERAGE

show-coverage : lcov open-coverage

format-coverage :
	dart pub global run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -o ./coverage/lcov.info -i ./coverage

gen-coverage :
	genhtml -o ./coverage/report ./coverage/lcov.info

open-coverage :
	open ./coverage/report/index.html

lcov : tests format-coverage gen-coverage
	