#!/sbin/sh
if [ -f /tmp/batterystats.bin ]; then
			if [ -d /data/system ]; then
				echo "/data/system is there"
			else
				mkdir /data/system
				chmod 0775 /data/system
				chown 1000:1000 /data/system
			fi
		echo "Moving batterystats.bin back to /data/system"
		mv /tmp/batterystats.bin /data/system
	else
		echo "No batterystats.bin backup found"
fi
# Restoring your previous vold.fstab
if [ -f /tmp/vold.fstab ]; then
			# Check if /system/etc exists (needed to check it for anyone who wiped)
			if [ -e /system/etc ]; then
				echo "/system/etc is there"
			else
				mkdir /system/etc
				chmod 0775 /system/etc
				#chown 1000:1000 /system/etc #must be root:root
			fi
		echo "Moving vold.fstab back to /system/etc"
		mv /tmp/vold.fstab /system/etc
	else
		echo "No vold.fstab backup found"
fi
/sbin/cp /tmp/recovery.log /sdcard/Darky/recovery.log
