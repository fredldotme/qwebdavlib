# Enable extended WebDAV properties (see QWebDavItem.h/cpp)
DEFINES += QWEBDAVITEM_EXTENDED_PROPERTIES

# DO NOT REMOVE - REQUIRED BY qwebdav_global.h
DEFINES += QWEBDAV_LIBRARY

SOURCES += $$PWD/qwebdav.cpp \
    $$PWD/qwebdavitem.cpp \
    $$PWD/qwebdavdirparser.cpp \
    $$PWD/qnaturalsort.cpp

HEADERS += $$PWD/qwebdav.h \
    $$PWD/qwebdavitem.h \
    $$PWD/qwebdavdirparser.h \
    $$PWD/qnaturalsort.h \
    $$PWD/qwebdav_global.h

