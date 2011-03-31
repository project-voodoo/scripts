#!/bin/sh
find linux_gt-i9000/Kernel/ -name '*.ko' -exec cp -v {} samsung_initramfs/froyo-i9000xxjpy/lib/modules \;
echo "`find linux_gt-i9000/Kernel/ -name '*.ko' | wc -l` module(s) copied"
