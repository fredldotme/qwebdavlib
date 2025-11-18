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

find_package(QWebdav REQUIRED)

add_executable(QWebdavExample)
target_sources(QWebdavExample
  PRIVATE
    main.cpp
    qexample.cpp
)
target_link_libraries(QWebdavExample
  PRIVATE
    QWebdav
)
