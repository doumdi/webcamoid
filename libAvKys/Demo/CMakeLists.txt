MESSAGE ( STATUS "Buiding AkKysDemo...")

find_package(Qt5Core REQUIRED)

include_directories(${AVKYS_INCLUDES} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR})

set (demo_headers
    main.h
)

set (demo_srcs
    main.cpp
)

#This will generate moc_* for Qt
QT5_WRAP_CPP(demo_moc_srcs ${demo_headers})


add_executable(AvKysDemo ${demo_srcs} ${demo_headers} ${demo_moc_srcs})
qt5_use_modules(AvKysDemo Core Concurrent Gui Qml)
target_link_libraries(AvKysDemo ${AVKYS_LIBS})




