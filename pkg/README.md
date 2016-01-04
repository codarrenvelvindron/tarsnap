OS-specific packaging bits for tarsnap
======================================

This directory contains bits to allow tarsnap to fit into operating system
package management systems.  I don't have access to all of these systems,
so please email me (at <cperciva@tarsnap.com>) if there are any problems
with these bits or if you can provide packaging bits for another OS.

Debian - Simple
---------------

To build a Debian package:

    ln -s pkg/debian .
    dpkg-buildpackage -b

Then to install it:

    sudo dpkg -i ../tarsnap_<version>_<arch>.deb


Debian - Packager
-----------------

This method is suitable for those wishing to distribute Tarsnap packages with
a view to reproducibility and cryptographically signed packages.

- (optional) create a tarball with:

        sh release-tools/mktarball.sh <version>

  Alternatively, place the actual release file in the root source directory.

- if you want to sign your source package and have multiple GPG identities,
  add a line like

        DEBUILD_DPKG_BUILDPACKAGE_OPTS="-k'0xC1ADD134'"

  to your `~/.devscripts`

  NOTE: setting up an environment variable will not work!  The above line
  (which selects which GPG key to use when signing the source package) only
  functions if it is inside `~/.devscripts`

- build the source package:

        sh release-tools/mkdebsource.sh <version>-<revision>

  Note: the revision number (e.g., -1) is required by the Debian packaging
  tools.

  This will give you the Debian source files in:

        /tmp/tarsnap-debian-source/

- If you want to distribute the source packages (via apt-get's deb-src),
  copy these files to the relevant directory and invoke your
  repository-handling software (e.g,. dpkg-scansources):

        /tmp/tarsnap-debian-source/*.dsc
        /tmp/tarsnap-debian-source/*.gz

- If you want to build a binary package directly, invoke:

        dpkg-source -x /tmp/tarsnap-debian/source/tarsnap_<version>-<revision>.dsc

  and then compile with:

        cd tarsnap-<version>
        dpkg-buildpackage

  and install with:

        sudo dpkg -i ../tarsnap_<version>_<arch>.deb


Arch Linux
----------

There is a PKGBUILD file for an earlier version of tarsnap in pkg/archlinux.
I can't include a PKGBUILD for the current version of tarsnap because the
PKGBUILD file contains the hash of the tarball which contains the PKGBUILD
file.  If you're running Arch Linux, you should know what to do with the
PKGBUILD file; but you may wish to change the pkgver=, md5sums=, and
sha256sums= lines so that you get the latest version of tarsnap.

There may be a newer version of the PKGBUILD file at

> http://www.archlinux.org/packages/community/i686/tarsnap/
> http://www.archlinux.org/packages/community/x86_64/tarsnap/

(in fact, those probably have identical PKGBUILD files).


Slackware
---------

There is a SlackBuild for tarsnap (possibly an earlier version) at

> http://slackbuilds.org/repository/${VER}/system/tarsnap/

for VER = 12.2 and 13.1 (and possibly other versions by the time
you read this).


FreeBSD, OpenBSD, and pkgsrc
----------------------------

Tarsnap is in the FreeBSD ports tree, the OpenBSD ports tree, and
the pkgsrc tree as sysutils/tarsnap.
