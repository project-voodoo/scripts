#!/sbin/sh

#Detecting kernel
if [ -f "/voodoo/run/cwm_recovery.fstab" ]; then

	# Mounting System
	if [ $(/sbin/mount | grep "on /system type" | wc -l) -eq "1" ]; then
		echo "SYSTEM is mounted"
		umount /system
		if [ $(/sbin/mount | grep "/dev/block/stl9 on /system" | wc -l) -eq "1" ]; then
			echo "SYSTEM is NOT successfully unmounted"
		else
			echo "SYSTEM is successfully ummounted"
		fi
	fi

	echo "mounting SYSTEM"
	if [ $(cat /voodoo/run/cwm_recovery.fstab | grep "/system ext4 /dev/block/stl9" | wc -l) -eq "1" ]; then
		echo "mounting SYSTEM as EXT4"
		/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/stl9 /system
		if [ $(/sbin/mount | grep "/dev/block/stl9 on /system type ext4" | wc -l) -eq "1" ]; then
			echo "SYSTEM is successfully mounted"
		else
			echo "SYSTEM is NOT successfully mounted"
		fi
	else
		echo "mounting SYSTEM as RFS"
		/sbin/mount -o rw /system
		if [ $(/sbin/mount | grep "/dev/block/stl9 on /system type rfs" | wc -l) -eq "1" ]; then
			echo "SYSTEM is successfully mounted"
		else
			echo "SYSTEM is NOT successfully mounted"
		fi
	fi

	# Mounting Data
	if [ $(/sbin/mount | grep "on /data type" | wc -l) -eq "1" ]; then
		echo "DATA is mounted"
		umount /data
		if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data" | wc -l) -eq "1" ]; then
			echo "DATA is NOT successfully unmounted"
		else
			echo "DATA is successfully ummounted"
		fi
	fi
	echo "mounting DATA"
	if [ $(cat /voodoo/run/cwm_recovery.fstab | grep "/data ext4 /dev/block/mmcblk0p2" | wc -l) -eq "1" ]; then
		echo "mounting DATA as EXT4"
		/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/mmcblk0p2 /data
		if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data type ext4" | wc -l) -eq "1" ]; then
			echo "DATA is successfully mounted"
		else
			echo "DATA is NOT successfully mounted"
		fi
	else
		echo "mounting DATA as RFS"
		/sbin/mount -o rw /data
		if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data type rfs" | wc -l) -eq "1" ]; then
			echo "DATA is successfully mounted"
		else
			echo "DATA is NOT successfully mounted"
		fi
	fi

	# Mounting DBData
	if [ $(/sbin/mount | grep "on /datadata type" | wc -l) -eq "1" ]; then
		echo "DBDATA is mounted"
		umount /datadata
		if [ $(/sbin/mount | grep "/dev/block/stl10 on /datadata" | wc -l) -eq "1" ]; then
			echo "DBDATA is NOT successfully unmounted"
		else
			echo "DBDATA is successfully ummounted"
		fi
	fi
	echo "mounting DBDATA"
	if [ $(cat /voodoo/run/cwm_recovery.fstab | grep "/datadata ext4 /dev/block/stl10" | wc -l) -eq "1" ]; then
		echo "mounting DBDATA as EXT4"
		/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/stl10 /datadata
		if [ $(/sbin/mount | grep "/dev/block/stl10 on /data type ext4" | wc -l) -eq "1" ]; then
			echo "DBDATA is successfully mounted"
		else
			echo "DBDATA is NOT successfully mounted"
		fi
	else
		echo "mounting DBDATA as RFS"
		mount /datadata
		if [ $(/sbin/mount | grep "/dev/block/stl10 on /datadata type rfs" | wc -l) -eq "1" ]; then
			echo "DBDATA is successfully mounted"
		else
			echo "DBDATA is NOT successfully mounted"
		fi
	fi
	
	# Detecting Voodoo
	if [ $(cat /voodoo/run/cwm_recovery.fstab | grep "/data ext4 /dev/block/mmcblk0p2" | wc -l) -eq "1" ]; then
		echo "Voodoo Lagfix detected"
		lagfix="1"
	else
		echo "Voodoo Lagfix was not detected"
		lagfix="0"
	fi

	if [ $(cat /voodoo/run/cwm_recovery.fstab | grep "/system ext4 /dev/block/stl9" | wc -l) -eq "1" ]; then
		echo "System Lagfix detected"
		sys_lagfix="1"
	else
		echo "System Lagfix was not detected"
		sys_lagfix="0"
	fi

	if [ -d "/sdcard/Voodoo" ]; then
		echo "Deleting old Voodoo Folder"
		/sbin/rm -Rf "/sdcard/Voodoo"
		if [ -e "/sdcard/Voodoo" ]; then
			echo "Old Voodoo Folder was not deleted"
		else
			echo "Old Voodoo Folder was deleted"
		fi
	fi

	echo "Creating New Voodoo Folder"
	mkdir "/sdcard/Voodoo"

	if [ $lagfix -eq "0" ]; then
		echo "Disabling Voodoo Lagfix"
		/sbin/touch "/sdcard/Voodoo/disable-lagfix"
	fi

	if [ $sys_lagfix -eq "0" ]; then
		echo "Disabling System Lagfix"
		/sbin/touch "/sdcard/Voodoo/system-as-rfs"
		/sbin/touch "/sdcard/Voodoo/dont-convert-system"
	fi
	
else
	echo "Voodoo based kernel NOT found"
	
	#setup voodoo
	if [ -d "/sdcard/Voodoo" ]; then
		echo "Deleting old Voodoo Folder"
		/sbin/rm -Rf "/sdcard/Voodoo"
		if [ -e "/sdcard/Voodoo" ]; then
			echo "Old Voodoo Folder was not deleted"
		else
			echo "Old Voodoo Folder was deleted"
		fi
	fi

	echo "Creating New Voodoo Folder"
	mkdir "/sdcard/Voodoo"
	
	# check and mount dbdata
	if [ $(/sbin/mount | grep "/dev/block/stl10 on /dbdata" | wc -l) -eq "1" ]; then
		echo "DBDATA is mounted at /dbdata"
		if [ -e "/datadata" ]; then
			/sbin/rm -Rf /datadata
		fi	
		ln -s /dbdata /datadata
	else
		if [ $(/sbin/mount | grep "/dev/block/stl10 on /datadata" | wc -l) -eq "1" ]; then
			echo "DBDATA is mounted at /datadata"
		else
			echo "DBDATA is NOT mounted"
			if [ -e "/datadata" ]; then
				echo "/datadata exists"
			else
				echo "creating /datadata"
				mkdir /datadata
			fi
			if tune2fs -l /dev/block/stl10 > /dev/null; then
				echo "mounting DBDATA as EXT4"
				/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/stl10 /datadata
				if [ $(/sbin/mount | grep "/dev/block/stl10 on /data type ext4" | wc -l) -eq "1" ]; then
					echo "DBDATA is successfully mounted"
				else
					echo "DBDATA is NOT successfully mounted"
				fi
			else
				echo "mounting DBDATA as RFS"
				mount -o rw /datadata
				if [ $(/sbin/mount | grep "/dev/block/stl10 on /datadata type rfs" | wc -l) -eq "1" ]; then
					echo "DBDATA is successfully mounted"
				else
					echo "DBDATA is NOT successfully mounted"
				fi
			fi
		fi
	fi
	
	# check and mount data
	if [ $(/sbin/mount | grep "on /data type" | wc -l) -eq "1" ]; then
		echo "DATA is mounted"
		if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data type rfs" | wc -l) -eq "1" ]; then
			echo "Disabling Voodoo Lagfix"
			/sbin/touch "/sdcard/Voodoo/disable-lagfix"
		fi
	else
		echo "mounting DATA"
		if tune2fs -l /dev/block/mmcblk0p2 > /dev/null; then
			echo "mounting DATA as EXT4"
			/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/mmcblk0p2 /data
			if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data type ext4" | wc -l) -eq "1" ]; then
				echo "DATA is successfully mounted"
			else
				echo "DATA is NOT successfully mounted"
			fi
		else
			echo "mounting DATA as RFS"
			/sbin/mount -o rw /data
			if [ $(/sbin/mount | grep "/dev/block/mmcblk0p2 on /data type rfs" | wc -l) -eq "1" ]; then
				echo "DATA is successfully mounted"
			else
				echo "DATA is NOT successfully mounted"
			fi
			echo "Disabling Voodoo Lagfix"
			/sbin/touch "/sdcard/Voodoo/disable-lagfix"
		fi
	fi
	
	# check and mount system
	if [ $(/sbin/mount | grep "on /system type" | wc -l) -eq "1" ]; then
		echo "SYSTEM is mounted"
		if [ $(/sbin/mount | grep "/dev/block/stl9 on /system type rfs" | wc -l) -eq "1" ]; then
			echo "Disabling System Lagfix"
			/sbin/touch "/sdcard/Voodoo/system-as-rfs"
			/sbin/touch "/sdcard/Voodoo/dont-convert-system"
		fi
	else
		echo "mounting SYSTEM"
		if [ tune2fs -l /dev/block/stl9 > /dev/null; ]; then
			echo "mounting SYSTEM as EXT4"
			/sbin/mount -t ext4 -o rw,noatime,barrier=0,data=writeback,noauto_da_alloc /dev/block/stl9 /system
			if [ $(/sbin/mount | grep "/dev/block/stl9 on /system type ext4" | wc -l) -eq "1" ]; then
				echo "SYSTEM is successfully mounted"
			else
				echo "SYSTEM is NOT successfully mounted"
			fi
		else
			echo "mounting SYSTEM as RFS"
			/sbin/mount -o rw /system
			if [ $(/sbin/mount | grep "/dev/block/stl9 on /system type rfs" | wc -l) -eq "1" ]; then
				echo "SYSTEM is successfully mounted"
			else
				echo "SYSTEM is NOT successfully mounted"
			fi
			echo "Disabling System Lagfix"
			/sbin/touch "/sdcard/Voodoo/system-as-rfs"
			/sbin/touch "/sdcard/Voodoo/dont-convert-system"
		fi
	fi
fi

# Backup current batterystats.bin
if [ -f /data/system/batterystats.bin ]; then
		echo "Copying batterystats.bin to /tmp"
		cp /data/system/batterystats.bin /tmp/
	else
		echo "No batterystats.bin found"
fi
