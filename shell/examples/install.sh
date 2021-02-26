#!/bin/bash

if [ "$(id -u)" -eq 0 ] ; then
	echo "ERROR: Don't run the installer.sh as root or via sudo."
	echo "       Simply invoke it with your regular user."
	exit 1
fi

cd "$(dirname "$0")"
cd data
export LD_LIBRARY_PATH="$(pwd):$LD_LIBRARY_PATH"

xhost + > /dev/null

#start
chmod a+x ./xDroidInstall
./xDroidInstall $@  || exit 1

XDROID_DIR=/opt/xdroid

# copy other files
FILES=(remove-xdroid )
for file in ${FILES[@]}; do
	if [ -f ${file} -a -d ${XDROID_DIR}/usr/bin ]; then
		chmod a+x ${file}
		cp -fd ${file}* ${XDROID_DIR}/usr/bin/
	fi
done
