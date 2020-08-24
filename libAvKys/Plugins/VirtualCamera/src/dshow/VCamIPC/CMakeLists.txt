include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set(VCamIPC_srcs
    src/ipcbridge.cpp
)

add_library(VCamIPC STATIC ${VCamIPC_srcs})
target_link_libraries(VCamIPC VCamUtils PlatformUtils advapi32 kernel32 psapi rstrtmgr)
