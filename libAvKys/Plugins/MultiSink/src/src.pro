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

TRANSLATIONS = $$files(../share/ts/*.ts)

exists(commons.pri) {
    include(commons.pri)
} else {
    exists(../../../commons.pri) {
        include(../../../commons.pri)
    } else {
        error("commons.pri file not found.")
    }
}

CONFIG += plugin

HEADERS = \
    multisink.h \
    multisinkelement.h \
    mediawriter.h \
    multisinkglobals.h \
    multisinkutils.h

INCLUDEPATH += \
    ../../../Lib/src

LIBS += -L$${PWD}/../../../Lib/ -l$${COMMONS_TARGET}

OTHER_FILES += ../pspec.json

QT += qml

RESOURCES = \
    ../MultiSink.qrc \
    ../translations.qrc

SOURCES = \
    multisink.cpp \
    multisinkelement.cpp \
    mediawriter.cpp \
    multisinkglobals.cpp \
    multisinkutils.cpp

lupdate_only {
    SOURCES += $$files(../share/qml/*.qml)
}

DESTDIR = $${OUT_PWD}/..
TARGET = MultiSink

TEMPLATE = lib

INSTALLS += target

target.path = $${LIBDIR}/$${COMMONS_TARGET}
