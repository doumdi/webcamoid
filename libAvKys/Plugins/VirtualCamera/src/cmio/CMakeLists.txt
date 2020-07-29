
set(AVKYS_LIB_DIR "\\\"LIB\\\"")
set(AVKYS_COMMONS_TARGET "\\\"AvKysPlugins\\\"")
set(AVKYS_DATAROOTDIR "\\\"Resources\\\"")


set(CMIO_PLUGINS_DAL_PATH "\\\"/Library/CoreMediaIO/Plug-Ins/DAL\\\"")
set(CMIO_PLUGINS_DAL_PATH_L "L\\\"/Library/CoreMediaIO/Plug-Ins/DAL\\\"")
set(CMIO_DAEMONS_PATH "\\\"~/Library/LaunchAgents\\\"")
set(CMIO_PLUGIN_NAME "\\\"AkVirtualCamera\\\"")
set(CMIO_PLUGIN_NAME_L "L\\\"AkVirtualCamera\\\"")
set(CMIO_PLUGIN_ASSISTANT_NAME "\\\"AkVCamAssistant\\\"")
set(CMIO_PLUGIN_ASSISTANT_NAME_L "L\\\"AkVCamAssistant\\\"")
set(CMIO_PLUGIN_DEVICE_PREFIX "\\\"/akvcam/video\\\"")
set(CMIO_PLUGIN_VENDOR "\\\"Webcamoid Project\\\"")
set(CMIO_PLUGIN_PRODUCT "\\\"AkVirtualCamera\\\"")

message(STATUS "************* ${CMIO_PLUGINS_DAL_PATH_L}")

add_definitions(-DCMIO_PLUGINS_DAL_PATH="${CMIO_PLUGINS_DAL_PATH}")
add_definitions(-DCMIO_PLUGINS_DAL_PATH_L="${CMIO_PLUGINS_DAL_PATH_L}")
add_definitions(-DCMIO_DAEMONS_PATH="${CMIO_DAEMONS_PATH}")
add_definitions(-DCMIO_PLUGIN_NAME="${CMIO_PLUGIN_NAME}")
add_definitions(-DCMIO_PLUGIN_NAME_L="${CMIO_PLUGIN_NAME_L}")
add_definitions(-DCMIO_PLUGIN_ASSISTANT_NAME="${CMIO_PLUGIN_ASSISTANT_NAME}")
add_definitions(-DCMIO_PLUGIN_ASSISTANT_NAME_L="${CMIO_PLUGIN_ASSISTANT_NAME_L}")
add_definitions(-DCMIO_PLUGIN_DEVICE_PREFIX="${CMIO_PLUGIN_DEVICE_PREFIX}")
add_definitions(-DCMIO_PLUGIN_VENDOR="${CMIO_PLUGIN_VENDOR}")
add_definitions(-DCMIO_PLUGIN_PRODUCT="${CMIO_PLUGIN_PRODUCT}")

add_subdirectory(VCamIPC)
add_subdirectory(Assistant)
add_subdirectory(VirtualCamera)
