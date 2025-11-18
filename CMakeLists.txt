cmake_minimum_required(VERSION 3.25.0 FATAL_ERROR)

project(QWebdav
  VERSION 1.0
  DESCRIPTION "WebDAV server access"
  HOMEPAGE_URL "https://github.com/fredldotme/qwebdavlib"
  LANGUAGES CXX
)

### Find ECM up-front and complain otherwise
#
#
include(FeatureSummary)
find_package(ECM 5.103.0 NO_MODULE)
set_package_properties(ECM
  PROPERTIES
    TYPE REQUIRED
    DESCRIPTION "Extra modules and scripts for CMake"
    URL "https://invent.kde.org/frameworks/extra-cmake-modules"
)
feature_summary(WHAT REQUIRED_PACKAGES_NOT_FOUND FATAL_ON_MISSING_REQUIRED_PACKAGES)

set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)

include(GenerateExportHeader)

include(ECMSetupVersion)
include(ECMGenerateHeaders)
include(CMakePackageConfigHelpers)

### Find available Qt build types
#
#
set(QT_NO_CREATE_VERSIONLESS_TARGETS ON)
set(QT5_REQUIRED_VERSION 5.15.0)
set(QT6_REQUIRED_VERSION 6.5.0)
find_package(Qt6 ${QT6_REQUIRED_VERSION} CONFIG COMPONENTS Core Network Xml)
find_package(Qt5 ${QT5_REQUIRED_VERSION} CONFIG COMPONENTS Core Network Xml)

set(WITH_QT5 FALSE) # Used when creating the Config.cmake file
set(WITH_QT6 FALSE)
if(TARGET Qt5::Core)
  message(STATUS "Building Qt5 version of ${PROJECT_NAME}")
  set(WITH_QT5 TRUE)
endif()
if(TARGET Qt6::Core)
  message(STATUS "Building Qt6 version of ${PROJECT_NAME}")
  set(WITH_QT6 TRUE)
endif()
if(NOT TARGET Qt5::Core AND NOT TARGET Qt6::Core)
  # If neither is found, complain about Qt5 because then the
  # error message says ">= 5.15.0" which reads most naturally.
  set_package_properties(Qt5
    PROPERTIES
      TYPE REQUIRED
      DESCRIPTION "Qt libraries (version 5 or 6)"
      URL "https://qt.io/"
  )
endif()

### QWebdav version header is independent of build type
#
#
ecm_setup_version(${PROJECT_VERSION}
  VARIABLE_PREFIX QWebdav
  VERSION_HEADER "${CMAKE_CURRENT_BINARY_DIR}/qwebdav_version.h"
  PACKAGE_VERSION_FILE "${CMAKE_CURRENT_BINARY_DIR}/QWebdavConfigVersion.cmake"
  SOVERSION 1
)
install(
  FILES
    "${CMAKE_CURRENT_BINARY_DIR}/qwebdav_version.h"
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/QWebdav
  COMPONENT devel
)

### Build
#
#
add_subdirectory(qwebdavlib)

### CMake Configuration Files
#
#
configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/QWebdavConfig.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/QWebdavConfig.cmake"
  INSTALL_DESTINATION ${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav
)
install(
  FILES
    "${CMAKE_CURRENT_BINARY_DIR}/QWebdavConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/QWebdavConfigVersion.cmake"
  DESTINATION "${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav"
  COMPONENT devel
)
install(
  EXPORT QWebdavTargets
  DESTINATION "${KDE_INSTALL_CMAKEPACKAGEDIR}/QWebdav"
  FILE QWebdavTargets.cmake
)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
