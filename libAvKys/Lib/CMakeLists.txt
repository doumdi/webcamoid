MESSAGE ( STATUS "Buiding AkCommons...")

find_package(Qt5Core REQUIRED)



add_definitions(-DQT_DEPRECATED_WARNINGS -DAKCOMMONS_LIBRARY)

if(APPLE)
    add_definitions(-DEXTENSION_SHLIB="dylib")
    add_definitions(-DPREFIX_SHLIB="lib")
    add_definitions(-DINSTALLPLUGINSDIR="AvKysPlugins")
    add_definitions(-DEXECPREFIX="exec")
endif()

if(UNIX AND NOT APPLE)
    add_definitions(-DEXTENSION_SHLIB="so")
    add_definitions(-DPREFIX_SHLIB="lib")
    add_definitions(-DINSTALLPLUGINSDIR="AvKysPlugins")
    add_definitions(-DEXECPREFIX="exec")
endif()

if(WIN32)
    add_definitions(-DEXTENSION_SHLIB="dll")
    add_definitions(-DPREFIX_SHLIB="")
    add_definitions(-DINSTALLPLUGINSDIR="AvKysPlugins")
    add_definitions(-DEXECPREFIX="exec")
endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
include_directories(${CMAKE_CURRENT_BINARY_DIR}/src)
include_directories(${CMAKE_CURRENT_BINARY_DIR}/src/qml)

set (libavkys_headers
    src/ak.h
    src/akaudiocaps.h
    src/akaudiopacket.h
    src/akcaps.h
    src/akcommons.h
    src/akelement.h
    src/akfrac.h
    src/akmultimediasourceelement.h
    src/akpacket.h
    src/akplugin.h
    src/akunit.h 
    src/akvideocaps.h
    src/akvideopacket.h
    src/qml/akcolorizedimage.h
    src/qml/akpalette.h
    src/qml/akpalettegroup.h
    src/qml/aktheme.h
)

set (libavkys_srcs
    src/ak.cpp
    src/akaudiocaps.cpp
    src/akaudiopacket.cpp
    src/akcaps.cpp
    src/akelement.cpp
    src/akfrac.cpp
    src/akmultimediasourceelement.cpp
    src/akpacket.cpp
    src/akunit.cpp
    src/akvideocaps.cpp
    src/akvideopacket.cpp
    src/qml/akcolorizedimage.cpp
    src/qml/akpalette.cpp
    src/qml/akpalettegroup.cpp
    src/qml/aktheme.cpp
)

#This will generate moc_* for Qt
QT5_WRAP_CPP(libavkys_moc_srcs ${libavkys_headers})

message(STATUS "MOC FILES : ${libavkys_moc_srcs} ${CMAKE_CURRENT_BINARY_DIR}")

add_custom_target(moc_files SOURCES ${libavkys_moc_srcs})
add_library(AvKys SHARED ${libavkys_srcs} ${libavkys_headers})
add_dependencies(AvKys moc_files)

qt5_use_modules(AvKys Core Concurrent Gui Qml Quick)

set(AVKYS_LIBS AvKys CACHE INTERNAL "doc string")
set(AVKYS_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_SOURCE_DIR}/src/qml CACHE INTERNAL "doc string")
#TODO DO BETTER?
set(AVKYS_PLUGIN_DIRECTORY ${EXECUTABLE_OUTPUT_PATH}/${AVKYS_COMMONS_TARGET} CACHE INTERNAL "doc string")
