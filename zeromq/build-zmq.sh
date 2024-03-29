#!/usr/bin/env bash

# check if we are root
if [ "$EUID" -ne 0 ] ; then
  echo "Please run as root"
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Please supply an OpenCV version number"
  echo "ex: ./build-zmq.sh 1.2.3"
  exit 1
fi

echo "$USER"
echo "start ---------------"

ZMQ_VERSION=$1
CURRDIR=$(pwd)
ZMQ_INSTALL_DIR="$CURRDIR/zeromq-dpkg/usr/local"

echo ""
echo "-------------------------------------------------"
echo "Installing to: $ZMQ_INSTALL_DIR"
echo "-------------------------------------------------"
echo ""


if [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
	echo "Upgrading software"
	echo ""
	# apt-get update
	apt-get -y upgrade
	apt-get -y install build-essential cmake git pkg-config
	apt-get -y install libtool autoconf automake uuid-dev libunwind-dev

	echo "System ready"
	echo ""
fi

if [ ! -f zeromq-$ZMQ_VERSION.tar.gz ]; then
	wget https://github.com/zeromq/libzmq/releases/download/v$ZMQ_VERSION/zeromq-$ZMQ_VERSION.tar.gz
else
	echo "Using previously downloaded file"
	rm -fr zeromq-$ZMQ_VERSION
fi

# setup things
tar zxf zeromq-$ZMQ_VERSION.tar.gz
cd zeromq-$ZMQ_VERSION
./configure --prefix=$ZMQ_INSTALL_DIR

# make and install
make -j4
make install
