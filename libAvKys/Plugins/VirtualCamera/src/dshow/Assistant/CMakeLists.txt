SET(EXECUTABLE_OUTPUT_PATH ${EXECUTABLE_OUTPUT_PATH}/AkVirtualCamera.plugin/${DSHOW_PLUGIN_ARCH})

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(assistant_headers
    src/service.h
)

set(assistant_srcs
    src/main.cpp
    src/service.cpp
)

add_executable(${DSHOW_PLUGIN_ASSISTANT_NAME} ${assistant_srcs} ${assistant_headers})
target_link_libraries(${DSHOW_PLUGIN_ASSISTANT_NAME} VCamUtils PlatformUtils advapi32 gdi32 ole32 shell32 strmiids uuid)

# Install
install(TARGETS ${DSHOW_PLUGIN_ASSISTANT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}/AkVirtualCamera.plugin/${DSHOW_PLUGIN_ARCH}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/AkVirtualCamera.plugin/${DSHOW_PLUGIN_ARCH}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}/AkVirtualCamera.plugin/${DSHOW_PLUGIN_ARCH})
