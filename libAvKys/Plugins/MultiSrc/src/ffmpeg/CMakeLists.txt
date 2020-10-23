set(SUBMMODULE_NAME "ffmpeg")
message(STATUS "Building ${PLUGIN_NAME} : ${SUBMMODULE_NAME} submodule.")

#FFMPEG DEFINITIONS
add_definitions(-D__STDC_CONSTANT_MACROS)
add_definitions(-DHAVE_BEST_EFFORT_TS)
add_definitions(-DHAVE_LIBAVDEVICE)

SET(LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})

find_package(Qt5Core REQUIRED)

include_directories(
    ${AVKYS_PLUGIN_INCLUDES}
    ${FFMPEG_INCLUDES}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/src
)

set (submodule_headers
    src/plugin.h
    src/mediasourceffmpeg.h
    src/abstractstream.h
    src/audiostream.h
    src/subtitlestream.h
    src/videostream.h
    src/clock.h
    ../mediasource.h
)

set (submodule_srcs
    src/plugin.cpp
    src/mediasourceffmpeg.cpp
    src/abstractstream.cpp
    src/audiostream.cpp
    src/subtitlestream.cpp
    src/videostream.cpp
    src/clock.cpp
    ../mediasource.cpp
)

set (submodule_qrc

)


#This will generate moc_* for Qt
QT5_WRAP_CPP(submodule_moc_srcs ${submodule_headers})
add_custom_target(${PLUGIN_NAME}_${SUBMMODULE_NAME}_src_mocs SOURCES ${submodule_moc_srcs})


QT5_ADD_RESOURCES(submodule_qrc_srcs ${summodule_qrc})

add_library(${PLUGIN_NAME}_${SUBMMODULE_NAME} SHARED ${submodule_srcs} ${submodule_headers} ${submodule_qrc_srcs})
add_dependencies(${PLUGIN_NAME}_${SUBMMODULE_NAME} ${PLUGIN_NAME}_${SUBMMODULE_NAME}_src_mocs)
qt5_use_modules(${PLUGIN_NAME}_${SUBMMODULE_NAME} Core Concurrent Widgets Gui Qml)
target_link_libraries(${PLUGIN_NAME}_${SUBMMODULE_NAME} ${AVKYS_PLUGIN_LIBRARIES} ${FFMPEG_LIBS})


# Install
install(TARGETS ${PLUGIN_NAME}_${SUBMMODULE_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/${AVKYS_LIBRARY_INSTALL_PATH}/submodules/${PLUGIN_NAME}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${AVKYS_LIBRARY_INSTALL_PATH}/submodules/${PLUGIN_NAME}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${AVKYS_LIBRARY_INSTALL_PATH}/submodules/${PLUGIN_NAME})
