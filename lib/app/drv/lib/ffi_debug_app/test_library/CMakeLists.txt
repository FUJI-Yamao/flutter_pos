cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(test_library VERSION 1.0.0 LANGUAGES C)
add_library(test_library SHARED test.c test.def)
add_executable(int_test test.c)

set_target_properties(test_library PROPERTIES
    PUBLIC_HEADER test.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "test"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)