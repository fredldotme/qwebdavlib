# Generated from qwebdavlib.pro.

#####################################################################
## qwebdav Generic Library:
#####################################################################

qt_internal_add_cmake_library(qwebdav
    SOURCES
        qnaturalsort.cpp qnaturalsort.h
        qwebdav.cpp qwebdav.h
        qwebdav_global.h
        qwebdavdirparser.cpp qwebdavdirparser.h
        qwebdavitem.cpp qwebdavitem.h
    DEFINES
        QWEBDAVITEM_EXTENDED_PROPERTIES
        QWEBDAV_LIBRARY
    PUBLIC_LIBRARIES
        Qt::Core
        Qt::Network
        Qt::Xml
    COMPILE_OPTIONS
        -Wno-overloaded-virtual
)

#### Keys ignored in scope 1:.:.:qwebdavlib.pro:<TRUE>:
# INSTALLS = "target"
# OTHER_FILES = "CHANGES" "LICENSE" "README"
# TEMPLATE = "lib"

## Scopes:
#####################################################################

qt_internal_extend_target(qwebdav CONDITION CMAKE_BUILD_TYPE STREQUAL Release
    DEFINES
        QT_NO_DEBUG_OUTPUT
)

#### Keys ignored in scope 2:.:.:qwebdavlib.pro:(CMAKE_BUILD_TYPE STREQUAL Release):
# QMAKE_POST_LINK = "$(STRIP)" "$(TARGET)"
