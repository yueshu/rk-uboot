#!/bin/bash
export CROSS_COMPILE=arm-linux-gnueabi-

BOARD=${1:-miniarm}

make ${BOARD}-rk3288_defconfig
make all -j 16
