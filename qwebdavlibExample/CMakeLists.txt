# QWebdav example application
#
# This example shows how to find QWebdav after is has been built and installed.
cmake_minimum_required(VERSION 3.25.0 FATAL_ERROR)

project(QWebdavExample
  VERSION 1.0
  DESCRIPTION "QWebDAV Example"
  HOMEPAGE_URL "https://github.com/fredldotme/qwebdavlib"
  LANGUAGES CXX
)

set(CMAKE_AUTOMOC ON)

# If we're building as part of the QWebDAV top-level build, we already
# have the target QWebdav available. In that case, do only the CMake-
# based build.
if(NOT TARGET QWebdav)
  # Outside of the QWebDAV top-level build, demonstrate both
  # CMake and pkgconfig approaches.

  # PkgConfig, first figure out which Qt version we want
  set(QT5_REQUIRED_VERSION 5.15.0)
  set(QT6_REQUIRED_VERSION 6.5.0)
  find_package(Qt6 ${QT6_REQUIRED_VERSION} CONFIG COMPONENTS Core Network Xml)
  find_package(Qt5 ${QT5_REQUIRED_VERSION} CONFIG COMPONENTS Core Network Xml)

  if(NOT TARGET Qt5::Core AND NOT TARGET Qt6::Core)
    message(FATAL_ERROR "No installed Qt version found.")
  endif()

  find_package(PkgConfig)
  if(PkgConfig_FOUND)
    if(TARGET Qt6::Core)
      pkg_check_modules(QWebdav IMPORTED_TARGET qwebdav-qt6)
    endif()
    if(TARGET Qt5::Core AND NOT TARGET PkgConfig::QWebdav)
      pkg_check_modules(QWebdav IMPORTED_TARGET qwebdav-qt5)
    endif()
  endif()

  find_package(QWebdav 1.0) # Works with whatever Qt versions are installed

  if(NOT TARGET QWebdav AND NOT TARGET PkgConfig::QWebdav)
    message(FATAL_ERROR "No installed QWebDAV found.")
  endif()
endif()

if(TARGET QWebdav)
  message(STATUS "Building QWebdavExample with CMake-found library")
  add_executable(QWebdavExample-cmake)
  target_sources(QWebdavExample-cmake
    PRIVATE
      main.cpp
      qexample.cpp
  )
  target_link_libraries(QWebdavExample-cmake
    PRIVATE
      QWebdav
  )
endif()

if(TARGET PkgConfig::QWebdav)
  message(STATUS "Building QWebdavExample with PkgConfig-found library")
  add_executable(QWebdavExample-pkgconfig)
  target_sources(QWebdavExample-pkgconfig
    PRIVATE
      main.cpp
      qexample.cpp
  )
  target_link_libraries(QWebdavExample-pkgconfig
    PRIVATE
      PkgConfig::QWebdav
  )
endif()
