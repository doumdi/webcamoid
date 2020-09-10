find_package(Qt5Core REQUIRED)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set (VCamIPC_srcs
    src/ipcbridge.cpp
)

add_library(VCamIPC STATIC ${VCamIPC_srcs})
qt5_use_modules(VCamIPC Core)
