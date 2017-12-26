#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
  echo "Please supply an OpenCV version number"
  echo "ex: ./build-pkg.sh 3.4.0"
  exit 1
fi

VERSION=$1

echo "building OpenCV ${VERSION}"
dpkg-deb -v --build zeromq-dpkg libzmq-${VERSION}.deb

echo ""
echo "reading debian package: \n"
dpkg-deb --info libzmq-${VERSION}.deb
