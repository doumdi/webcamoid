#We will only build specific plugins for now

# Base plugins
#SUBDIRS += \
#    ACapsConvert \
#    AudioDevice \
#    AudioGen \
#    Bin \
#    DesktopCapture \
#    Multiplex \
#    MultiSink \
#    MultiSrc \
#    Probe \
#    VideoCapture \
#    VirtualCamera

SET(AVKYS_PLUGIN_INCLUDES
    ${AVKYS_INCLUDES}
)

SET(AVKYS_PLUGIN_LIBRARIES
    ${AVKYS_LIBS}
)

#Will output in the right directory
FILE(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH}/AvKysPlugins)
SET(LIBRARY_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH}/AvKysPlugins)
SET (AVKYS_LIBRARY_INSTALL_PATH AvKysPlugins)

add_subdirectory(MultiSrc)
add_subdirectory(VirtualCamera)
add_subdirectory(ACapsConvert)
add_subdirectory(DesktopCapture)
