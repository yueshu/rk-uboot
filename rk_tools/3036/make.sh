#!/bin/bash
export CROSS_COMPILE=arm-linux-gnueabi-

BOARD=${1:-kylin}

make ${BOARD}-rk3036_defconfig
make all -j 16
