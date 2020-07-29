set(SUBMMODULE_NAME "ffmpegsw")
message(STATUS "Building ${PLUGIN_NAME} : ${SUBMMODULE_NAME} submodule.")

#FFMPEG DEFINITIONS
add_definitions(-D__STDC_CONSTANT_MACROS)

SET(LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})

find_package(Qt5Core REQUIRED)

include_directories(
    ${AVKYS_PLUGIN_INCLUDES}
    ${FFMPEG_INCLUDES}
    ./
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/src
)

set (submodule_headers
    src/plugin.h
    src/convertaudioffmpegsw.h
    ../convertaudio.h
)

set (submodule_srcs
    src/plugin.cpp
    src/convertaudioffmpegsw.cpp
    ../convertaudio.cpp
)

set (submodule_qrc

)


#This will generate moc_* for Qt
QT5_WRAP_CPP(submodule_moc_srcs ${submodule_headers})
add_custom_target(${PLUGIN_NAME}_${SUBMMODULE_NAME}_src_mocs SOURCES ${submodule_moc_srcs})

QT5_ADD_RESOURCES(submodule_qrc_srcs ${summodule_qrc})

add_library(${PLUGIN_NAME}_${SUBMMODULE_NAME} SHARED ${submodule_srcs} ${submodule_headers} ${submodule_qrc_srcs})
set_target_properties(${PLUGIN_NAME}_${SUBMMODULE_NAME} PROPERTIES OUTPUT_NAME "ffmpegsw" )
qt5_use_modules(${PLUGIN_NAME}_${SUBMMODULE_NAME} Core Concurrent Widgets Gui Qml)
target_link_libraries(${PLUGIN_NAME}_${SUBMMODULE_NAME} ${AVKYS_PLUGIN_LIBRARIES} ${FFMPEG_LIBS})
add_dependencies(${PLUGIN_NAME}_${SUBMMODULE_NAME} ${PLUGIN_NAME}_${SUBMMODULE_NAME}_src_mocs)


