#!/bin/sh

cd /tmp
tar cvf Gingerbread-GT-I9000-stock-kernel+hacks.tar zImage
cp /tmp/Gingerbread-GT-I9000-stock-kernel+hacks.tar /home/share/voodoo-dl/
echo ./scripts/sync_downloads.sh
