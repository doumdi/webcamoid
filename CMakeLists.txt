project(webcamoid)

cmake_minimum_required(VERSION 3.8)

#This will enable to output everything in the bin directory for testing and debugging...
SET (EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET (LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
SET (ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)


#TODO UPDATE THOSE VARIABLES
set(AVKYS_LIB_DIR "\\\"LIB\\\"")
set(AVKYS_COMMONS_TARGET "\\\"AvKysPlugins\\\"")
add_definitions(-DQT_INSTALL_QML -DLIBDIR="${AVKYS_LIB_DIR}" -DCOMMONS_TARGET="${AVKYS_COMMONS_TARGET}")

#FFMPEG HARD CODED FOR NOW
#Useful definitions
if(APPLE)
    #Installed DLLS (from homebrew)
    FILE(GLOB FFMPEG_DLL "/usr/local/opt/ffmpeg/lib/*.dylib")
    MESSAGE ( STATUS "FFMpeg libs = ${FFMPEG_DLL}")

    set(FFMPEG_INCLUDES /usr/local/opt/ffmpeg/include CACHE INTERNAL "doc string")
    set(FFMPEG_LIBS "-L/usr/local/opt/ffmpeg/lib/ -lavcodec -lavfilter -lavutil -lswresample -lavdevice -lavformat -lpostproc -lswscale" CACHE INTERNAL "doc string")


endif(APPLE)


if(WIN32)

    #Hard coded path for now
    set(FFMPEG_PATH "C:/Libs/ffmpeg")

    FILE(GLOB FFMPEG_DLL "${FFMPEG_PATH}/bin/*.dll")
    MESSAGE ( STATUS "FFMpeg libs = ${FFMPEG_DLL}")

    #FOR SOME REASON, DLLs ARE IN THE BIN DIRECTORY...
    INSTALL(FILES ${FFMPEG_DLL} DESTINATION bin)

    #For IN-SOURCE debug
    file(COPY ${FFMPEG_DLL} DESTINATION ${EXECUTABLE_OUTPUT_PATH})

    #FOR MSVC
    set(ffmpeg_lib_names
        ${FFMPEG_PATH}/lib/avcodec.lib
        ${FFMPEG_PATH}/lib/avfilter.lib
        ${FFMPEG_PATH}/lib/avutil.lib
        ${FFMPEG_PATH}/lib/swresample.lib
        ${FFMPEG_PATH}/lib/avdevice.lib
        ${FFMPEG_PATH}/lib/avformat.lib
        ${FFMPEG_PATH}/lib/postproc.lib
        ${FFMPEG_PATH}/lib/swscale.lib
    )

    #for linking and compiling
    set(FFMPEG_INCLUDES "${FFMPEG_PATH}/include " CACHE INTERNAL "doc string")
    message ( STATUS "FFMpeg includes = ${FFMPEG_INCLUDES}")

    set(FFMPEG_LIBS "${ffmpeg_lib_names}" CACHE INTERNAL "doc string")
    message ( STATUS "FFMpeg libs = ${FFMPEG_LIBS}")

endif(WIN32)


#add subdirectories
add_subdirectory(libAvKys)

