include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set (PlatformUtils_srcs
    src/messageserver.cpp
    src/mutex.cpp
    src/utils.cpp
    src/sharedmemory.cpp
)

set (PlatformUtils_headers
    src/messagecommons.h
    src/messageserver.h
    src/mutex.h
    src/utils.h
)


add_library(PlatformUtils STATIC ${PlatformUtils_srcs} ${PlatformUtils_headers})
target_link_libraries(PlatformUtils VCamUtils advapi32 kernel32 gdi32 shell32)
