TEMPLATE = subdirs

SUBDIRS += \
    qwebdavlib \
    qwebdavlibExample

qwebdavlibExample.depends = qwebdavlib
