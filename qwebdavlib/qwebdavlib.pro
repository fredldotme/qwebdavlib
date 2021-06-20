QT       += network xml

# for a qwebdavlib without support for GUI
QT       -= gui

TARGET = qwebdav
TEMPLATE = lib

!macx {
    CONFIG(release, debug|release) {
        QMAKE_POST_LINK=$(STRIP) $(TARGET)
        DEFINES += QT_NO_DEBUG_OUTPUT
    }
}

QMAKE_CXXFLAGS += -Wno-overloaded-virtual

include(qwebdavlib.pri)

OTHER_FILES += \
    CHANGES \
    LICENSE \
    README

INSTALLS += target
