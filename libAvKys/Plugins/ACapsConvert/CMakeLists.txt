set(PLUGIN_NAME ACapsConvert)
message(STATUS "Building ${PLUGIN_NAME} Plugin.")

add_definitions(-DUNICODE)

find_package(Qt5Core REQUIRED)

include_directories(
    ${AVKYS_PLUGIN_INCLUDES}
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/src
)

set (plugin_headers
    src/acapsconvert.h
    src/acapsconvertelement.h
    src/acapsconvertelementsettings.h
    src/acapsconvertglobals.h
    src/convertaudio.h
)

set (plugin_srcs
    src/acapsconvert.cpp
    src/acapsconvertelement.cpp
    src/acapsconvertelementsettings.cpp
    src/acapsconvertglobals.cpp
    src/convertaudio.cpp
)

set (plugin_qrc

)


#This will generate moc_* for Qt
QT5_WRAP_CPP(plugin_moc_srcs ${plugin_headers})
add_custom_target(${PLUGIN_NAME}_src_mocs SOURCES ${plugin_moc_srcs})


QT5_ADD_RESOURCES(plugin_qrc_srcs ${plugin_qrc})

add_library(${PLUGIN_NAME} SHARED ${plugin_srcs} ${plugin_headers} ${plugin_qrc_srcs})
qt5_use_modules(${PLUGIN_NAME} Core Concurrent Gui Qml)
add_dependencies(${PLUGIN_NAME} ${PLUGIN_NAME}_src_mocs)
target_link_libraries(${PLUGIN_NAME} ${AVKYS_PLUGIN_LIBRARIES})


#submodule(s)
FILE(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})

# Install
install(TARGETS ${PLUGIN_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/${AVKYS_LIBRARY_INSTALL_PATH}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/${AVKYS_LIBRARY_INSTALL_PATH}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/${AVKYS_LIBRARY_INSTALL_PATH})


add_subdirectory(src/ffmpegsw)
