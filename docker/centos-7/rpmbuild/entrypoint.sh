#!/bin/bash
# copy files to /tmp
cd /tmp
cp -rvf /root/${PACKAGE}/* /tmp

ARCH=$(uname -m)
RPMROOT=/root/rpmbuild

# install rpmbuild sources
cp -vf ${PACKAGE}-${VERSION}.tar.gz ${RPMROOT}/SOURCES/ || exit 1
cp packaging/rpmbuild/${PACKAGE}.spec ${RPMROOT}/SPECS/ || exit 1

# build
rpmbuild -ba ${RPMROOT}/SPECS/${PACKAGE}.spec || exit 1

# copy out of container
cp -vf \
	${RPMROOT}/RPMS/${ARCH}/${PACKAGE}-${VERSION}-1.el7.centos.${ARCH}.rpm \
	/root/${PACKAGE}/${PACKAGE}-${VERSION}-1.el7.${ARCH}.rpm \
	|| exit 1
