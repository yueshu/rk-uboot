#!/bin/sh
PROGRAM=${0##*/}
LOCAL_PATH=${0%/*}

LOADER=${1:-RK3288_uboot.img}

SPL_BIN=spl/u-boot-spl-dtb.bin
UBOOT_BIN=u-boot-dtb.bin
PARTITION_TABLE_SIZE_KB=32

# add spl bin
tools/mkimage -n rk3288 -T rksd -d ${SPL_BIN} ${LOADER}
# add uboot
#cat ${UBOOT_BIN} >> ${LOADER}
#truncate -s $((4 * 1024 - ${PARTITION_TABLE_SIZE_KB}))K ${LOADER}

echo Done...
