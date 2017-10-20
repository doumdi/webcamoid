project(webcamoid)


#This will enable to output everything in the bin directory for testing and debugging...
SET (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET (LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET (ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)


#TODO UPDATE THOSE VARIABLES
set(AVKYS_LIB_DIR "\\\"LIB\\\"")
set(AVKYS_COMMONS_TARGET "\\\"PLUGINS\\\"")
add_definitions(-DQT_INSTALL_QML -DLIBDIR="${AVKYS_LIB_DIR}" -DCOMMONS_TARGET="${AVKYS_COMMONS_TARGET}")

#FFMPEG HARD CODED FOR NOW

#Installed DLLS (from homebrew)
FILE(GLOB FFMPEG_DLL "/usr/local/opt/ffmpeg/lib/*.dylib")
MESSAGE ( STATUS "FFMpeg libs = ${FFMPEG_DLL}")

#Useful definitions
set(FFMPEG_INCLUDES /usr/local/opt/ffmpeg/include CACHE INTERNAL "doc string")
set(FFMPEG_LIBS "-L/usr/local/opt/ffmpeg/lib/ -lavcodec -lavfilter -lavutil -lswresample -lavdevice -lavformat -lpostproc -lswscale" CACHE INTERNAL "doc string")

#add subdirectories
add_subdirectory(libAvKys)

