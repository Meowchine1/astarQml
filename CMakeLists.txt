cmake_minimum_required(VERSION 3.14)
project(AstarGraphicApp VERSION 0.1 LANGUAGES CXX)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT ${QT_VERSION_MAJOR} widgets)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}")
# Make Qt Creator aware of where the QML modules live
set (_QML_IMPORT_PATHS "")
## Add new module paths here.
list (APPEND _QML_IMPORT_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/qml)
set (
    QML_IMPORT_PATH
    ${_QML_IMPORT_PATHS}
    CACHE
    STRING
    "Path used to locate CMake modules by Qt Creator"
    FORCE
)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)

file(GLOB SOURCE_FILES "application/*.cpp"
    "application/*.h"
    "uiModels/*.cpp"
    "uiModels/*.h"
    "resourses/*.png")

set(PROJECT_SOURCES ${SOURCE_FILES} qml.qrc)

add_executable(AstarGraphicApp ${PROJECT_SOURCES})

find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS QuickControls2)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt${QT_VERSION_MAJOR}::QuickControls2)
target_link_libraries(AstarGraphicApp PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

set_target_properties(AstarGraphicApp PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

install(TARGETS AstarGraphicApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(${QT_VERSION_MAJOR} EQUAL 6)
    qt_import_qml_plugins(AstarGraphicApp)
    qt_finalize_executable(AstarGraphicApp)
endif()
