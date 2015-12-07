#!/bin/sh

BUILDDIR=/tmp/tarsnap-debian-source/

IFS='-' read -r VERSION REVISION <<EOF
$1
EOF

if [ -z $VERSION ] || [ -z $REVISION ]; then
        echo "Please specify the version and revision number, i.e. 1.0.37-1"
        exit 1
fi

# normal
TARBALL=tarsnap-autoconf-${VERSION}.tgz
TARDEBDIR=tarsnap-autoconf-${VERSION}
TARDEB=tarsnap_${VERSION}.orig.tar.gz

# debian
TARDEBDEB=tarsnap_${VERSION}-${REVISION}.debian.tar.gz

# normal tarball
mkdir -p $BUILDDIR
cp $TARBALL $BUILDDIR

# debian extras
cd pkg/
tar -czf $TARDEBDEB debian/
mv $TARDEBDEB $BUILDDIR

# prep
cd $BUILDDIR
mv $TARBALL $TARDEB
tar -xzf $TARDEB
cd $TARDEBDIR
tar -xzf ../$TARDEBDEB

debuild -S

