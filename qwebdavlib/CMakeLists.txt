# Boilerplate for building the library against a given Qt version
function(add_qwebdav_library QT_VERSION)
  add_library(QWebdav-qt${QT_VERSION})
  target_sources(QWebdav-qt${QT_VERSION}
    PRIVATE
      qnaturalsort.cpp
      qwebdav.cpp
      qwebdavdirparser.cpp
      qwebdavitem.cpp
  )

  target_compile_definitions(QWebdav-qt${QT_VERSION}
    PRIVATE
      QWEBDAV_LIBRARY=1
      QWEBDAVITEM_EXTENDED_PROPERTIES=1
  )
  if(CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(QWebdav-qt${QT_VERSION}
      PRIVATE
        QT_NO_DEBUG_OUTPUT=1
    )
  endif()

  target_compile_options(QWebdav-qt${QT_VERSION}
    PRIVATE
      -Wno-overloaded-virtual
  )

  target_include_directories(QWebdav-qt${QT_VERSION}
    INTERFACE
      "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/QWebdav>"
  )

  target_link_libraries(QWebdav-qt${QT_VERSION}
    PUBLIC
      Qt${QT_VERSION}::Core
      Qt${QT_VERSION}::Network
      Qt${QT_VERSION}::Xml
  )
endfunction()

if(TARGET Qt5::Core)
  add_qwebdav_library(5)
endif()
if(TARGET Qt6::Core)
  add_qwebdav_library(6)
endif()

