cmake_minimum_required(VERSION 3.14)

project(AstarGraphicApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT ${QT_VERSION_MAJOR} widgets)


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

#find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)
find_package(Qt5 REQUIRED COMPONENTS Core Quick)



set(CPP main.cpp node.cpp graph.cpp astar.cpp
     appcore.cpp tablemodel.cpp listmodel.cpp)
set(HEADER node.h graph.h heuristic.h
    splitter.h astar.h appcore.h tablemodel.h listmodel.h NodeException.h)

set(PROJECT_SOURCES ${CPP}  ${HEADER} qml.qrc
)

add_executable(AstarGraphicApp
          ${PROJECT_SOURCES}
)

#if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
#    qt_add_executable(AstarGraphicApp
#        MANUAL_FINALIZATION
#        ${PROJECT_SOURCES}
#    )
## Define target properties for Android with Qt 6 as:
##    set_property(TARGET AstarGraphicApp APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
##                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
## For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
#else()
#    if(ANDROID)
#        add_library(AstarGraphicApp SHARED
#            ${PROJECT_SOURCES}
#        )
## Define properties for Android with Qt 5 after find_package() calls as:
##    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
#    else()
#        add_executable(AstarGraphicApp
#          ${PROJECT_SOURCES}
#        )
#    endif()
#endif()

target_link_libraries(AstarGraphicApp
  PRIVATE Qt5::Core Qt5::Quick)

find_package(Qt5 REQUIRED COMPONENTS QuickControls2)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::QuickControls2)

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

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(AstarGraphicApp)
    qt_finalize_executable(AstarGraphicApp)
endif()
