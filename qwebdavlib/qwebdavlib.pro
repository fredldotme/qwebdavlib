TEMPLATE = lib
TARGET = qwebdav-qt$${QT_MAJOR_VERSION}
VERSION = 1.0.0

QT       += network xml
# for a qwebdavlib without support for GUI
QT       -= gui

!macx {
    CONFIG(release, debug|release) {
        QMAKE_POST_LINK=$(STRIP) $(TARGET)
        DEFINES += QT_NO_DEBUG_OUTPUT
    }
}

QMAKE_CXXFLAGS += -Wno-overloaded-virtual

include($$PWD/../common-install.pri)

# Enable extended WebDAV properties (see QWebDavItem.h/cpp)
DEFINES += QWEBDAVITEM_EXTENDED_PROPERTIES

# DO NOT REMOVE - REQUIRED BY qwebdav_global.h
DEFINES += QWEBDAV_LIBRARY

public_headers = \
    qwebdav.h \
    qwebdav_global.h \
    qwebdavitem.h \
    qwebdavdirparser.h

private_headers = \
    qnaturalsort.h

HEADERS = \
    $$public_headers \
    $$private_headers

SOURCES = \
    qwebdav.cpp \
    qwebdavitem.cpp \
    qwebdavdirparser.cpp \
    qnaturalsort.cpp

OTHER_FILES = \
    CHANGES \
    LICENSE \
    README

target.path  = $${INSTALL_LIBS}
INSTALLS    += target

headers.files  = $$public_headers
headers.path   = $${INSTALL_HEADERS}/$${TARGET}
INSTALLS      += headers

unix {
    pkgconfig.files      = $${TARGET}.pc
    pkgconfig.path       = $${INSTALL_LIBS}/pkgconfig
    pkgconfig.CONFIG     = no_check_exist
    QMAKE_SUBSTITUTES   += $${pkgconfig.files}.in
    QMAKE_EXTRA_TARGETS += pkgconfig
    QMAKE_CLEAN         += $${pkgconfig.files}
    INSTALLS            += pkgconfig
}
