#!/bin/sh
PROGRAM=${0##*/}
LOCAL_PATH=${0%/*}

LOADER=${1:-RK3036_uboot.img}

SPL_BIN=spl/u-boot-spl.bin
UBOOT_BIN=u-boot-dtb.bin
PARTITION_TABLE_SIZE_KB=32

# add spl bin
tools/mkimage -n rk3036 -T rksd -d ${SPL_BIN} ${LOADER}
cat ${UBOOT_BIN} >> ${LOADER}
# add uboot
#truncate -s $((4 * 1024 - ${PARTITION_TABLE_SIZE_KB}))K ${LOADER}

echo Done...
