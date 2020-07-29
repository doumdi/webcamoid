include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set (VCamIPC_srcs
    src/ipcbridge.mm
)

add_library(VCamIPC STATIC ${VCamIPC_srcs})
