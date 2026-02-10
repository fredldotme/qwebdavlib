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
    EXPORT QWebdav${QT_VERSION}Targets
    ${KDE_INSTALL_TARGETS_DEFAULT_ARGS}
  )

  generate_export_header(qwebdav-qt${QT_VERSION})

  # One copy of the headers per Qt-version, even though they are
  # identical: this is so that you can build packages of Qt5 and Qt6
  # libraries separately and they won't collide over the headers.
  install(
    FILES
      # Generated export-header isn't used (qwebdav_global contains similar
      # definitions) and the naturalsort header is for internal use.
      #
      # ${CMAKE_CURRENT_BINARY_DIR}/qwebdav_export.h
      # qnaturalsort.h
      qwebdav.h
      qwebdav_global.h
      qwebdavdirparser.h
      qwebdavitem.h
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/QWebdav${QT_VERSION}
    COMPONENT devel
  )
  install(
    FILES
      "${CMAKE_BINARY_DIR}/qwebdav_version.h"
    DESTINATION ${KDE_INSTALL_INCLUDEDIR}/QWebdav${QT_VERSION}
    COMPONENT devel
  )

  ### CMake Configuration Files
  #
  #
  configure_package_config_file(
    "${CMAKE_SOURCE_DIR}/QWebdavConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/QWebdav${QT_VERSION}Config.cmake"
    INSTALL_DESTINATION ${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav${QT_VERSION}
  )
  install(
    FILES
      "${CMAKE_CURRENT_BINARY_DIR}/QWebdav${QT_VERSION}Config.cmake"
    DESTINATION "${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav${QT_VERSION}"
    COMPONENT devel
  )
  install(
    FILES
      "${CMAKE_BINARY_DIR}/QWebdavConfigVersion.cmake"
    RENAME
      "QWebdav${QT_VERSION}ConfigVersion.cmake"
    DESTINATION "${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav${QT_VERSION}"
    COMPONENT devel
  )
  install(
    EXPORT QWebdav${QT_VERSION}Targets
    DESTINATION "${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav${QT_VERSION}"
    FILE QWebdav${QT_VERSION}Targets.cmake
  )
endfunction()

if(WITH_QT5)
  add_qwebdav_library(5)
endif()
if(WITH_QT6)
  add_qwebdav_library(6)
endif()
