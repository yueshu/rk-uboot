#!/bin/bash
PROGRAM=${0##*/}
LOCAL_PATH=${0%/*}

LOADER=${1:-RK3036_uboot.img}

DDRINIT=${LOCAL_PATH}/RK3036_DDR3_400M_V1.06.bin
USBPLUG=${LOCAL_PATH}/rk303xusbplug.bin

function usage()
{
	echo "Script to flash rk3036 loader image."
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

while ! sudo lsusb -d 2207:301a ; do sleep .5; done

echo "Flashing ${LOADER}..."

echo rc4 ddrinit $DDRINIT
cat $DDRINIT | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool l
sleep 1
echo rc4:usbplug $USBPLUG
cat $USBPLUG | openssl rc4 -K 7c4e0304550509072d2c7b38170d1711 | sudo rkflashtool L
sleep 2
LOADER_SIZE=$(wc -c $LOADER  | awk '{print int($1/512 + 1)}')
echo loader: $LOADER, size: $LOADER_SIZE
sudo rkflashtool w 64 $LOADER_SIZE <$LOADER

sudo rkflashtool b
