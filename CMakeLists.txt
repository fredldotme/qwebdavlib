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

### Find available Qt build types
#
#
set(QT_NO_CREATE_VERSIONLESS_TARGETS ON)
find_package(Qt6 6.5.0 CONFIG COMPONENTS Core Network Xml)
find_package(Qt5 5.15.0 CONFIG COMPONENTS Core Network Xml)

if(TARGET Qt5::Core)
  message(STATUS "Building Qt5 version of ${PROJECT_NAME}")
endif()
if(TARGET Qt6::Core)
  message(STATUS "Building Qt6 version of ${PROJECT_NAME}")
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

### Build
#
#
add_subdirectory(qwebdavlib)

feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
