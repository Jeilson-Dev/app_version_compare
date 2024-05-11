# SETUP:
get :
	dart pub get

# TESTS:

tests : 
	flutter test --coverage

# TEST COVERAGE

show-coverage : tests lcov

lcov-ignore : 
	lcov --remove coverage/lcov.info 'lib/core/*' 'lib/theme/*' 'lib/models/*.g.dart' -o coverage/lcov.info

lcov : tests lcov-ignore
	genhtml -q -o coverage coverage/lcov.info && open coverage/index.html
