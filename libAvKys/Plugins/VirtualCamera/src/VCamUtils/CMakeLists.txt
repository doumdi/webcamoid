
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)
add_definitions(-DQT_DEBUG)

set(LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH}/submodules/${PLUGIN_NAME})

set (VCamUtils_headers
    src/fraction.h
    src/image/color.h
    src/image/videoformat.h
    src/image/videoframe.h
    src/image/videoframetypes.h
    src/image/videoformattypes.h
    src/logger/logger.h
    src/timer.h
    src/utils.h
)

set (VCamUtils_srcs
    src/fraction.cpp
    src/image/videoformat.cpp
    src/image/videoframe.cpp
    src/logger/logger.cpp
    src/timer.cpp
    src/utils.cpp
)

add_library(VCamUtils STATIC ${VCamUtils_headers} ${VCamUtils_srcs})
