set(PLUGIN_NAME MultiSrc)
message(STATUS "Building ${PLUGIN_NAME} Plugin.")


find_package(Qt5Core REQUIRED)

include_directories(
    ${AVKYS_PLUGIN_INCLUDES}
    ${CMAKE_CURRENT_BINARY_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src
)


set (plugin_headers
    src/multisrc.h
    src/multisrcelement.h
    src/multisrcelementsettings.h
    src/mediasource.h
    src/multisrcglobals.h
)

set (plugin_srcs
    src/multisrc.cpp
    src/multisrcelement.cpp
    src/multisrcelementsettings.cpp
    src/mediasource.cpp
    src/multisrcglobals.cpp
)

set (plugin_qrc
    MultiSrc.qrc
)



#This will generate moc_* for Qt
QT5_WRAP_CPP(plugin_moc_srcs ${plugin_headers})
add_custom_target(${PLUGIN_NAME}_src_mocs SOURCES ${plugin_moc_srcs})

QT5_ADD_RESOURCES(plugin_qrc_srcs ${plugin_qrc})


add_library(${PLUGIN_NAME} SHARED ${plugin_srcs} ${plugin_headers} ${plugin_qrc_srcs})
qt5_use_modules(${PLUGIN_NAME} Core Concurrent Gui Qml)
target_link_libraries(${PLUGIN_NAME} ${AVKYS_PLUGIN_LIBRARIES})
add_dependencies(${PLUGIN_NAME} ${PLUGIN_NAME}_src_mocs)


#submodule(s)
FILE(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})
add_subdirectory(src/ffmpeg)
