#!/bin/bash
PROGRAM=${0##*/}
LOCAL_PATH=${0%/*}

LOADER=${1:-RK3288_uboot.img}

function usage()
{
	echo "Script to flash rk3288 loader image."
	echo "usage:"
	echo -e "\t${0} <loader image path>"
	echo -e "\tdefault is ${LOADER}"
}

if [ ! -f ${LOADER} ];then
	echo "${LOADER} not exist!"
	usage
	exit -1
fi

echo "Waiting for rockchip device..."

while ! sudo lsusb -d 2207:320a ; do sleep .5; done

echo "Flashing ${LOADER}..."

sudo ~/bin/upgrade_tool db ${LOCAL_PATH}/rk3288_boot.bin
sudo ~/bin/upgrade_tool wl 64 ${LOADER}
sudo ~/bin/upgrade_tool wl 256 u-boot.img
sudo ~/bin/upgrade_tool rd
