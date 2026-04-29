cmake_minimum_required(VERSION 3.16)

project(untitled VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Svg)

qt_standard_project_setup(REQUIRES 6.8)

file(GLOB_RECURSE QML_FILES_ABSOLUTE
    "${CMAKE_CURRENT_SOURCE_DIR}/src/ui/*.qml"
)

set(QML_FILES)
foreach(_qml_file ${QML_FILES_ABSOLUTE})
    file(RELATIVE_PATH _rel_path "${CMAKE_CURRENT_SOURCE_DIR}" "${_qml_file}")
    list(APPEND QML_FILES ${_rel_path})
endforeach()

set(SOURCE_FILES
    main.cpp
    src/core/Calculator.cpp
    src/core/Calculator.h
)

qt_add_executable(appuntitled
    ${SOURCE_FILES}
    resources.qrc
)

qt_add_qml_module(appuntitled
    URI untitled
    QML_FILES ${QML_FILES}
)

target_link_libraries(appuntitled
    PRIVATE Qt6::Quick Qt6::Svg
)

install(TARGETS appuntitled
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
