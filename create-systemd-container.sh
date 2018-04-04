#!/bin/sh

if [ $1 ]
then
	PREFIX=$1
else
	PREFIX=$(pwd)
fi

CONTAINER_DIR=$PREFIX/newimage
SETTINGS_DIR=$PREFIX/newsettings
STORAGE_DIR=$PREFIX/newstorage
MACHINE_NAME=seafileserver

mkdir -p $CONTAINER_DIR
rm mkosi
wget https://raw.githubusercontent.com/systemd/mkosi/master/mkosi
chmod +x mkosi.postinst

mkosi -t directory -o $CONTAINER_DIR --force --with-network

# Copy initial files to fresh bind
mkdir -p $SETTINGS_DIR
systemd-nspawn -M $MACHINE_NAME -D $CONTAINER_DIR --bind=$SETTINGS_DIR:/mysettings -- /bin/bash -c "cp -Rpn /settings/* /mysettings/"
mkdir -p $STORAGE_DIR
systemd-nspawn -M $MACHINE_NAME -D $CONTAINER_DIR --bind=$STORAGE_DIR:/mystorage -- /bin/bash -c "cp -Rpn /storage/* /mystorage/"

# To boot the new machine,
#    systemd-nspawn -M seafileserver -D $CONTAINER_DIR --bind=$(pwd)/mysettings:/settings -b
# To boot with an own ip, see setup-bridge.md
#    systemd-nspawn -M seafileserver -D $CONTAINER_DIR --bind=$(pwd)/mysettings:/settings --network-bridge=br_wired -b

# To access the audioserver, you simply need to run for root access
#    machinectl shell seafileserver
# or for user access
#    machinectl shell seafile@seafileserver

