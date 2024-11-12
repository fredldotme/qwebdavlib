TEMPLATE = app
TARGET = qwebdav-test-console

CONFIG += console
CONFIG -= app_bundle

QT += core network xml
QT -= gui

SOURCES += \
    main.cpp \
    qexample.cpp

win32:CONFIG(release, debug|release) {
    # WINDOWS RELEASE
    PRE_TARGETDEPS += $$OUT_PWD/../qwebdavlib/release/libqwebdav.a
    INCLUDEPATH += $$OUT_PWD/../qwebdavlib/
    LIBS += -L$$OUT_PWD/../qwebdavlib/release/ -lqwebdav-qt$${QT_MAJOR_VERSION}
} else:win32:CONFIG(debug, debug|release) {
    # WINDOWS DEBUG
    PRE_TARGETDEPS += $$OUT_PWD/../qwebdavlib/debug/libqwebdav.a
    INCLUDEPATH += $$OUT_PWD/../qwebdavlib/
    LIBS += -L$$OUT_PWD/../qwebdavlib/debug/ -lqwebdav-qt$${QT_MAJOR_VERSION}
} else {
    INCLUDEPATH += $$PWD/../qwebdavlib
    LIBS += -L$$OUT_PWD/../qwebdavlib -lqwebdav-qt$${QT_MAJOR_VERSION}
}

HEADERS += \
    qexample.h

target.path  = $${INSTALL_BINS}
INSTALLS    += target
