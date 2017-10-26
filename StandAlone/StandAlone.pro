# Webcamoid, webcam capture application.
# Copyright (C) 2011-2017  Gonzalo Exequiel Pedone
#
# Webcamoid is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Webcamoid is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Webcamoid. If not, see <http://www.gnu.org/licenses/>.
#
# Web-Site: http://webcamoid.github.io/

TRANSLATIONS_PRI = ../translations.pri

exists(translations.qrc) {
    TRANSLATIONS = $$files(share/ts/*.ts)
    RESOURCES += translations.qrc
}

exists(commons.pri) {
    include(commons.pri)
} else {
    exists(../commons.pri) {
        include(../commons.pri)
    } else {
        error("commons.pri file not found.")
    }
}

!isEmpty(BUILDDOCS):!isEqual(BUILDDOCS, 0) {
    DOCSOURCES = ../$${COMMONS_APPNAME}.qdocconf

    builddocs.input = DOCSOURCES
    builddocs.output = share/docs_auto/html/$${COMMONS_TARGET}.index
    builddocs.commands = $${QDOCTOOL} ${QMAKE_FILE_IN}
    builddocs.variable_out = DOCSOUTPUT
    builddocs.name = Docs ${QMAKE_FILE_IN}
    builddocs.CONFIG += target_predeps

    QMAKE_EXTRA_COMPILERS += builddocs
    PRE_TARGETDEPS += compiler_builddocs_make_all
}

unix {
    MANPAGESOURCES = share/man/man1/$${COMMONS_TARGET}.1

    buildmanpage.input = MANPAGESOURCES
    buildmanpage.output = ${QMAKE_FILE_IN}.gz
    buildmanpage.commands = gzip -c9 ${QMAKE_FILE_IN} > ${QMAKE_FILE_IN}.gz
    buildmanpage.CONFIG += no_link

    QMAKE_EXTRA_COMPILERS += buildmanpage
    PRE_TARGETDEPS += compiler_buildmanpage_make_all
}

CONFIG += qt
!isEmpty(STATIC_BUILD):!isEqual(STATIC_BUILD, 0): CONFIG += static

HEADERS = \
    src/mediatools.h \
    src/videodisplay.h \
    src/iconsprovider.h \
    src/audiolayer.h \
    src/videoeffects.h \
    src/mediasource.h \
    src/pluginconfigs.h \
    src/clioptions.h \
    src/recording.h \
    src/updates.h

INCLUDEPATH += \
    ../libAvKys/Lib/src

LIBS += -L$${PWD}/../libAvKys/Lib -lavkys
win32: LIBS += -lole32

OTHER_FILES = \
    share/effects.xml
unix: OTHER_FILES += $${MANPAGESOURCES}

QT += qml quick opengl widgets svg

RESOURCES += \
    Webcamoid.qrc \
    qml.qrc \
    share/icons/icons.qrc

SOURCES = \
    src/main.cpp \
    src/mediatools.cpp \
    src/videodisplay.cpp \
    src/iconsprovider.cpp \
    src/audiolayer.cpp \
    src/videoeffects.cpp \
    src/mediasource.cpp \
    src/pluginconfigs.cpp \
    src/clioptions.cpp \
    src/recording.cpp \
    src/updates.cpp

lupdate_only {
    SOURCES += $$files(share/qml/*.qml)
}

DESTDIR = $${OUT_PWD}

TARGET = $${COMMONS_TARGET}

macx: ICON = share/icons/webcamoid.icns
!unix: RC_ICONS = share/icons/hicolor/256x256/webcamoid.ico

TEMPLATE = app

# http://www.loc.gov/standards/iso639-2/php/code_list.php

CODECFORTR = UTF-8
CODECFORSRC = UTF-8

INSTALLS += target

target.path = $${BINDIR}

!unix {
    INSTALLS += \
        appIcon

    appIcon.files = share/icons/hicolor/256x256/webcamoid.ico
    appIcon.path = $${PREFIX}
}

unix:!macx {
    INSTALLS += \
        manpage \
        appIcon8x8 \
        appIcon16x16 \
        appIcon22x22 \
        appIcon32x32 \
        appIcon48x48 \
        appIcon64x64 \
        appIcon128x128 \
        appIcon256x256 \
        appIconScalable

    manpage.files = share/man/man1/webcamoid.1.gz
    manpage.path = $${MANDIR}/man1
    manpage.CONFIG += no_check_exist

    appIcon8x8.files = share/icons/hicolor/8x8/webcamoid.png
    appIcon8x8.path = $${DATAROOTDIR}/icons/hicolor/8x8/apps

    appIcon16x16.files = share/icons/hicolor/16x16/webcamoid.png
    appIcon16x16.path = $${DATAROOTDIR}/icons/hicolor/16x16/apps

    appIcon22x22.files = share/icons/hicolor/22x22/webcamoid.png
    appIcon22x22.path = $${DATAROOTDIR}/icons/hicolor/22x22/apps

    appIcon32x32.files = share/icons/hicolor/32x32/webcamoid.png
    appIcon32x32.path = $${DATAROOTDIR}/icons/hicolor/32x32/apps

    appIcon48x48.files = share/icons/hicolor/48x48/webcamoid.png
    appIcon48x48.path = $${DATAROOTDIR}/icons/hicolor/48x48/apps

    appIcon64x64.files = share/icons/hicolor/64x64/webcamoid.png
    appIcon64x64.path = $${DATAROOTDIR}/icons/hicolor/64x64/apps

    appIcon128x128.files = share/icons/hicolor/128x128/webcamoid.png
    appIcon128x128.path = $${DATAROOTDIR}/icons/hicolor/128x128/apps

    appIcon256x256.files = share/icons/hicolor/256x256/webcamoid.png
    appIcon256x256.path = $${DATAROOTDIR}/icons/hicolor/256x256/apps

    appIconScalable.files = share/icons/hicolor/scalable/webcamoid.svg
    appIconScalable.path = $${DATAROOTDIR}/icons/hicolor/scalable/apps
}

!isEmpty(BUILDDOCS):!isEqual(BUILDDOCS, 0) {
    INSTALLS += docs

    docs.files = share/docs_auto/html
    docs.path = $${HTMLDIR}
    docs.CONFIG += no_check_exist
}
