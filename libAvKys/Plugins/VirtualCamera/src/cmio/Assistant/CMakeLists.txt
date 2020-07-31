include_directories(${CMAKE_CURRENT_SOURCE_DIR})



set(assistant_srcs
    src/main.cpp
    src/assistant.cpp
)

add_executable(${CMIO_PLUGIN_ASSISTANT_NAME} ${assistant_srcs})
target_link_libraries(${CMIO_PLUGIN_ASSISTANT_NAME} VCamUtils "-framework CoreFoundation")

