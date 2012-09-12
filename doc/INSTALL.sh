#!/bin/sh

[ -z $AE_EXT ] && echo 'Set AE_EXT to point to install directory for jshon/jansson' && exit 1

mkdir -p $AE_EXT

echo "installing jansson..."

cd $AE_EXT
curl http://www.digip.org/jansson/releases/jansson-2.3.1.tar.gz | tar zxf -
ln -s jansson* jansson
cd jansson
./configure
make

echo "installing jshon..."

cd $AE_EXT
curl http://kmkeen.com/jshon/jshon.tar.gz | \
tar zxf -
cd jshon
export C_INCLUDE_PATH=$AE_EXT/jansson/src
export LIBRARY_PATH=$AE_EXT/jansson/src/.libs
make

echo; echo; echo; echo; echo
echo "BRILLIANT..."
echo; echo; echo; echo; echo
echo "now add the following lines to your ~/.profile or equivalent:"
echo
[ "`uname -s`" = "Darwin" ] && sprinkle=DY
echo '    export AE_EXT='${AE_EXT}
echo '    export PATH=$AE_EXT/jshon:$PATH'
echo '    export '$sprinkle'LD_LIBRARY_PATH=$AE_EXT/jansson/src/.libs'
echo
