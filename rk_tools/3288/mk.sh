#!/bin/sh
PROGRAM=${0##*/}
LOCAL_PATH=${0%/*}

LOADER=${1:-RK3288_uboot.img}

TEMP_DIR=${LOCAL_PATH}/tmp
DDR_BIN=${LOCAL_PATH}/32_LPDDR2_300MHz_LPDDR3_300MHz_DDR3_300MHz_20140630.bin
SPL_BIN=spl.bin
UBOOT_BIN=u-boot-dtb.bin

rm -r ${LOADER} 2>/dev/null

dd if=${DDR_BIN} of=${SPL_BIN} bs=4 skip=1

# add spl bin(with signature)
tools/mkimage -n rk3288 -T rksd -d ${SPL_BIN} ${LOADER}
# add loader
cat ${UBOOT_BIN} >> ${LOADER}

echo Done...
