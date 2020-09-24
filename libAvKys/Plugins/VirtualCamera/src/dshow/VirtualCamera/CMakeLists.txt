
SET(LIBRARY_OUTPUT_PATH ${EXECUTABLE_OUTPUT_PATH}/AkVirtualCamera.plugin/${DSHOW_PLUGIN_ARCH})

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set(VirtualCamera_headers
    src/basefilter.h
    src/classfactory.h
    src/cunknown.h
    src/enummediatypes.h
    src/enumpins.h
    src/filtermiscflags.h
    src/latency.h
    src/mediafilter.h
    src/mediasample.h
    src/mediasample2.h
    src/memallocator.h
    src/persist.h
    src/persistpropertybag.h
    src/pin.h
    src/plugin.h
    src/plugininterface.h
    src/propertyset.h
    src/pushsource.h
    src/qualitycontrol.h
    src/referenceclock.h
    src/specifypropertypages.h
    src/streamconfig.h
    src/videocontrol.h
    src/videoprocamp.h
)

set(VirtualCamera_srcs
    src/basefilter.cpp
    src/classfactory.cpp
    src/cunknown.cpp
    src/enummediatypes.cpp
    src/enumpins.cpp
    src/filtermiscflags.cpp
    src/latency.cpp
    src/mediafilter.cpp
    src/mediasample.cpp
    src/mediasample2.cpp
    src/memallocator.cpp
    src/persist.cpp
    src/persistpropertybag.cpp
    src/pin.cpp
    src/plugin.cpp
    src/plugininterface.cpp
    src/propertyset.cpp
    src/pushsource.cpp
    src/qualitycontrol.cpp
    src/referenceclock.cpp
    src/specifypropertypages.cpp
    src/streamconfig.cpp
    src/videocontrol.cpp
    src/videoprocamp.cpp
)

set(VirtualCamera_def VirtualCamera.def)

add_library(${DSHOW_PLUGIN_NAME} SHARED ${VirtualCamera_srcs} ${VirtualCamera_headers})
target_link_libraries(${DSHOW_PLUGIN_NAME}
    VCamIPC
    PlatformUtils
    VCamUtils
    advapi32
    gdi32
    kernel32
    ole32
    oleaut32
    shell32
    strmiids
    user32
    uuid
    winmm)
