# Boilerplate for building the library against a given Qt version
function(add_qwebdav_library QT_VERSION)
  add_library(qwebdav-qt${QT_VERSION})
  target_sources(qwebdav-qt${QT_VERSION}
    PRIVATE
      qnaturalsort.cpp
      qwebdav.cpp
      qwebdavdirparser.cpp
      qwebdavitem.cpp
  )

  target_compile_definitions(qwebdav-qt${QT_VERSION}
    PRIVATE
      QWEBDAV_LIBRARY=1
      QWEBDAVITEM_EXTENDED_PROPERTIES=1
  )
  if(CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(qwebdav-qt${QT_VERSION}
      PRIVATE
        QT_NO_DEBUG_OUTPUT=1
    )
  endif()

  target_compile_options(qwebdav-qt${QT_VERSION}
    PRIVATE
      -Wno-overloaded-virtual
  )

  target_include_directories(qwebdav-qt${QT_VERSION}
    INTERFACE
      "$<INSTALL_INTERFACE:${KDE_INSTALL_INCLUDEDIR}/QWebdav>"
  )

  target_link_libraries(qwebdav-qt${QT_VERSION}
    PUBLIC
      Qt${QT_VERSION}::Core
      Qt${QT_VERSION}::Network
      Qt${QT_VERSION}::Xml
  )

  set_target_properties(qwebdav-qt${QT_VERSION}
    PROPERTIES
      VERSION ${QWebdav_VERSION}
      SOVERSION ${QWebdav_SOVERSION}
      EXPORT_NAME "qwebdav-qt${QT_VERSION}"
  )

  install(
    TARGETS qwebdav-qt${QT_VERSION}
    EXPORT QWebdavTargets
    ${KDE_INSTALL_TARGETS_DEFAULT_ARGS}
  )
endfunction()

if(WITH_QT5)
  add_qwebdav_library(5)
  add_library(QWebdav ALIAS qwebdav-qt5)
endif()
if(WITH_QT6)
  add_qwebdav_library(6)
  if(NOT TARGET QWebdav)
    add_library(QWebdav ALIAS qwebdav-qt6)
  endif()
endif()

# Only one export header, regardless of which libraries are built
generate_export_header(QWebdav)

# Only one copy of the headers, regardless of which libraries are built
install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/qwebdav_export.h
    qnaturalsort.h
    qwebdav.h
    qwebdav_global.h
    qwebdavdirparser.h
    qwebdavitem.h
  DESTINATION ${KDE_INSTALL_INCLUDEDIR}/QWebdav
  COMPONENT devel
)
