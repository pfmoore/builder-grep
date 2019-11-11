#!/bin/sh

# Change this to build a different version of grep
GREP_VER=3.3

wget http://ftp.gnu.org/gnu/grep/grep-${GREP_VER}.tar.xz
tar xf grep-${GREP_VER}.tar.xz
cd grep-${GREP_VER}

# Static to avoid depending on libpcre.dll at runtime
# Also needs -DPCRE_STATIC to tell the PCRE headers we are doing a static
# link.
mingw64-configure CFLAGS="-DPCRE_STATIC" LDFLAGS="-static" --disable-nls

# Hack around error in gnulib-tests (which doesn't matter)
mv gnulib-tests gnulib-tests#
mkdir gnulib-tests
echo all: >gnulib-tests/Makefile

make

TARGET=../grep-${GREP_VER}.zip
zip -j9 ${TARGET} */*.exe

# Display the results
echo
echo
echo Generated executable archive:
echo
ls -l ${TARGET}
unzip -l ${TARGET}
