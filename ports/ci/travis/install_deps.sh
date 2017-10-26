#!/bin/bash

if [ "${TRAVIS_OS_NAME}" = linux ] && [ "${ANDROID_BUILD}" != 1 ]; then
    mkdir -p .local/bin

    # Install Qt Installer Framework
    wget -c http://download.qt.io/official_releases/qt-installer-framework/${QTIFWVER}/QtInstallerFramework-linux-x64.run
    chmod +x QtInstallerFramework-linux-x64.run

    QT_QPA_PLATFORM=minimal \
    ./QtInstallerFramework-linux-x64.run \
        -v \
        --script "$PWD/ports/ci/travis/qtifw_non_interactive_install.qs" \
        --no-force-installations

    cp -vf ~/Qt/QtIFW-${QTIFWVER/-*/}/bin/* .local/bin/

    # Install AppImageTool
    wget -c -O .local/bin/appimagetool-x86_64.AppImage https://github.com/AppImage/AppImageKit/releases/download/9/appimagetool-x86_64.AppImage
    chmod +x .local/bin/appimagetool-x86_64.AppImage

    cd .local/bin
    ./appimagetool-x86_64.AppImage --appimage-extract
    cp -vf squashfs-root/usr/bin/* .
    cd ../..

    # Set default Docker command
    EXEC="docker exec ${DOCKERSYS}"
fi

if [ "${ANDROID_BUILD}" = 1 ]; then
    sudo apt-get -y install make

    mkdir -p build
    cd build

    # Install Android NDK
    wget -c https://dl.google.com/android/repository/android-ndk-${NDKVER}-linux-x86_64.zip
    unzip -q android-ndk-${NDKVER}-linux-x86_64.zip

    # Install Qt for Android
    wget -c https://download.qt.io/archive/qt/${QTVER:0:3}/${QTVER}/qt-opensource-linux-x64-${QTVER}.run
    chmod +x qt-opensource-linux-x64-${QTVER}.run

    QT_QPA_PLATFORM=minimal \
    ./qt-opensource-linux-x64-${QTVER}.run \
        -v \
        --script "$PWD/../ports/ci/travis/qt_non_interactive_install.qs" \
        --no-force-installations
elif [ "${DOCKERSYS}" = debian ]; then
    ${EXEC} apt-get -y update

    if [ "${DOCKERIMG}" = ubuntu:trusty ]; then
        ${EXEC} apt-get -y install software-properties-common
        ${EXEC} add-apt-repository ppa:beineri/opt-qt${PPAQTVER}-trusty
    elif [ "${DOCKERIMG}" = ubuntu:xenial ]; then
        ${EXEC} apt-get -y install software-properties-common
        ${EXEC} add-apt-repository ppa:beineri/opt-qt${PPAQTVER}-xenial
    fi

    ${EXEC} apt-get -y update
    ${EXEC} apt-get -y upgrade

    # Install dev tools
    ${EXEC} apt-get -y install \
        xvfb \
        g++ \
        clang \
        ccache \
        make \
        pkg-config \
        linux-libc-dev \
        libgl1-mesa-dev \
        libpulse-dev \
        libjack-dev \
        libasound2-dev \
        libv4l-dev \
        libgstreamer-plugins-base1.0-dev

    # Install Qt dev
    if [ "${DOCKERIMG}" = ubuntu:trusty ] || \
       [ "${DOCKERIMG}" = ubuntu:xenial ]; then
        ${EXEC} apt-get -y install \
            qt${PPAQTVER:0:2}tools \
            qt${PPAQTVER:0:2}declarative \
            qt${PPAQTVER:0:2}multimedia \
            qt${PPAQTVER:0:2}svg \
            qt${PPAQTVER:0:2}quickcontrols2 \
            qt${PPAQTVER:0:2}graphicaleffects
    else
        ${EXEC} apt-get -y install \
            qt5-qmake \
            qtdeclarative5-dev \
            qtmultimedia5-dev \
            libqt5opengl5-dev \
            libqt5svg5-dev \
            qtquickcontrols2-5-dev \
            qml-module-qt-labs-folderlistmodel \
            qml-module-qt-labs-settings \
            qml-module-qtqml-models2 \
            qml-module-qtquick-controls2 \
            qml-module-qtquick-dialogs \
            qml-module-qtquick-extras \
            qml-module-qtquick-privatewidgets
    fi

    # Install FFmpeg dev
    ${EXEC} apt-get -y install \
        libavcodec-dev \
        libavdevice-dev \
        libavformat-dev \
        libavutil-dev \
        libavresample-dev \
        libswscale-dev

    if [ "${DOCKERIMG}" != ubuntu:trusty ]; then
        ${EXEC} apt-get -y install \
            libswresample-dev
    fi
elif [ "${DOCKERSYS}" = fedora ]; then
    ${EXEC} dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORAVER}.noarch.rpm
    ${EXEC} dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORAVER}.noarch.rpm
    ${EXEC} dnf -y update

    ${EXEC} dnf -y install \
        file \
        which \
        xorg-x11-xauth \
        xorg-x11-server-Xvfb \
        ccache \
        clang \
        make \
        gcc-c++ \
        qt5-qttools-devel \
        qt5-qtdeclarative-devel \
        qt5-qtmultimedia-devel \
        qt5-qtsvg-devel \
        qt5-qtquickcontrols2-devel \
        qt5-qtgraphicaleffects \
        ffmpeg-devel \
        gstreamer1-plugins-base-devel \
        libv4l-devel \
        alsa-lib-devel \
        pulseaudio-libs-devel \
        jack-audio-connection-kit-devel
elif [ "${DOCKERSYS}" = opensuse ]; then
    ${EXEC} zypper -n update

    ${EXEC} zypper -n in \
        which \
        xauth \
        xvfb-run \
        python3 \
        ccache \
        clang \
        libqt5-linguist \
        libqt5-qtbase-devel \
        libqt5-qtdeclarative-devel \
        libqt5-qtmultimedia-devel \
        libqt5-qtsvg-devel \
        libqt5-qtquickcontrols2 \
        libQt5QuickControls2-devel \
        libqt5-qtgraphicaleffects \
        ffmpeg-devel \
        gstreamer-plugins-base-devel \
        libv4l-devel \
        alsa-devel \
        libpulse-devel \
        libjack-devel
elif [ "${TRAVIS_OS_NAME}" = osx ]; then
    brew install \
        p7zip \
        python3 \
        ccache \
        pkg-config \
        qt5 \
        ffmpeg \
        gstreamer \
        gst-plugins-base \
        pulseaudio \
        jack \
        libuvc

    # Install Qt Installer Framework
    wget -c http://download.qt.io/official_releases/qt-installer-framework/${QTIFWVER}/QtInstallerFramework-mac-x64.dmg
    7z x -oqtifw QtInstallerFramework-mac-x64.dmg
    7z x -oqtifw qtifw/5.hfsx
    chmod +x qtifw/QtInstallerFramework-mac-x64/QtInstallerFramework-mac-x64.app/Contents/MacOS/QtInstallerFramework-mac-x64

    qtifw/QtInstallerFramework-mac-x64/QtInstallerFramework-mac-x64.app/Contents/MacOS/QtInstallerFramework-mac-x64 \
        -v \
        --script "$PWD/ports/ci/travis/qtifw_non_interactive_install.qs" \
        --no-force-installations

    # Install Syphon framework
    wget -c https://github.com/Syphon/Simple/releases/download/version-3/Syphon.Simple.Apps.3.zip
    unzip Syphon.Simple.Apps.3.zip
    mkdir -p Syphon
    cp -Rvf "Syphon Simple Apps/Simple Client.app/Contents/Frameworks/Syphon.framework" ./Syphon
fi
