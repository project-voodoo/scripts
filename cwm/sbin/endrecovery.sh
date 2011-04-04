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
/sbin/cp /tmp/recovery.log /sdcard/Darky/recovery.log
