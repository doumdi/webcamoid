SET(LIBRARY_OUTPUT_PATH ${EXECUTABLE_OUTPUT_PATH}/AkVirtualCamera.plugin)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMIO_BASE_INCLUDES})

set(cmio_VirtualCamera_headers
    src/plugin.h
    src/plugininterface.h
    src/utils.h
    src/device.h
    src/object.h
    src/stream.h
    src/objectinterface.h
    src/objectproperties.h
    src/clock.h
    src/queue.h
)

set(cmio_VirtualCamera_srcs
    src/plugin.cpp
    src/plugininterface.cpp
    src/utils.cpp
    src/device.cpp
    src/object.cpp
    src/stream.cpp
    src/objectinterface.cpp
    src/objectproperties.cpp
    src/clock.cpp
 )

add_library(${CMIO_PLUGIN_NAME} SHARED ${cmio_VirtualCamera_headers} ${cmio_VirtualCamera_srcs})
target_link_libraries(${CMIO_PLUGIN_NAME} VCamIPC VCamUtils
    "-framework CoreFoundation"
    "-framework CoreMedia"
    "-framework CoreMediaIO"
    "-framework CoreVideo"
    "-framework Foundation"
    "-framework IOKit"
    "-framework IOSurface"
)

# TODO Handle Other files
# $$sprintf($$QMAKE_MKDIR_CMD, $$shell_path($${OUT_PWD}/$${TARGET}.plugin/Contents/MacOS)) $${CMD_SEP} \
# $$sprintf($$QMAKE_MKDIR_CMD, $$shell_path($${OUT_PWD}/$${TARGET}.plugin/Contents/Resources)) $${CMD_SEP} \
# $(COPY) $$shell_path($${PWD}/Info.plist) $$shell_path($${OUT_PWD}/$${TARGET}.plugin/Contents) $${CMD_SEP} \
# $(COPY) $$shell_path($${OUT_PWD}/$${BIN_DIR}/lib$${TARGET}.dylib) $$shell_path($${OUT_PWD}/$${TARGET}.plugin/Contents/MacOS/$${TARGET}) $${CMD_SEP} \
# $(COPY) $$shell_path($${PWD}/../../../share/TestFrame/TestFrame.bmp) $$shell_path($${OUT_PWD}/$${TARGET}.plugin/Contents/Resources)
