set(PLUGIN_NAME VirtualCamera)
message(STATUS "Building ${PLUGIN_NAME} Plugin.")

add_definitions(-DUNICODE)

find_package(Qt5Core REQUIRED)

include_directories(
    ${AVKYS_PLUGIN_INCLUDES}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/src
)

set (plugin_headers
    src/virtualcamera.h
    src/virtualcameraelement.h
    src/ipcbridge.h
)

set (plugin_srcs
    src/virtualcamera.cpp
    src/virtualcameraelement.cpp
)

set (plugin_qrc
    VirtualCamera.qrc
)


add_subdirectory(src/VCamUtils)


if(APPLE)
    add_subdirectory(src/cmio)
endif()



#This will generate moc_* for Qt
QT5_WRAP_CPP(plugin_moc_srcs ${plugin_headers})
add_custom_target(${PLUGIN_NAME}_src_mocs SOURCES ${plugin_moc_srcs})

QT5_ADD_RESOURCES(plugin_qrc_srcs ${plugin_qrc})
add_library(${PLUGIN_NAME} SHARED ${plugin_srcs} ${plugin_headers} ${plugin_qrc_srcs})
qt5_use_modules(${PLUGIN_NAME} Core Concurrent Gui Qml)
# Link step below
add_dependencies(${PLUGIN_NAME} ${PLUGIN_NAME}_src_mocs)

#submodule(s)
FILE(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})

if(WIN32)
    add_subdirectory(src/dshow)
endif()

if(APPLE)
    target_link_libraries(${PLUGIN_NAME} ${AVKYS_PLUGIN_LIBRARIES} VCamIPC VCamUtils "-framework Foundation" "-framework IOSurface")
    # add_subdirectory(src/ffmpeg)
endif()
