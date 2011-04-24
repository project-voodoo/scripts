#!/bin/bash

mode=$1

do_things()
{
	if test "$mode" = "status"; then
		make clean
		echo 
		pwd
		echo
		git status
		read
	else
		git add ./sound/soc/codecs/wm8994*.c 2>/dev/null
		git add ./sound/soc/codecs/victory/wm8994*.c
		git add ./sound/soc/codecs/wm8994_voodoo.h 2>/dev/null
		git add ./sound/soc/codecs/victory/wm8994_voodoo.h
		git add ./sound/soc/codecs/Makefile
		git add ./sound/soc/codecs/Kconfig.voodoo
		git add ./sound/soc/Kconfig
		git diff --cached
		git commit && git push
	fi
	
	cd - > /dev/null 2>&1
}

cd nexuss/ && do_things

cd linux_gt-i9000-gingerbread/ && do_things

cd linux_galaxys-cm7/ && do_things

cd linux_gt-i9000-eclair/linux-2.6.29/ && do_things

cd linux_sch-i800/Kernel/ && do_things

cd linux_sch-i500/Kernel/ && do_things

cd linux_gt-i9000/linux-2.6.29/ && do_things

cd linux_sgh-t959/ && do_things

cd linux_sgh-t959v/ && do_things

cd linux_sgh-i897/ && do_things

cd linux_shw-m110s/ && do_things

cd linux_sph-d700-eclair/linux-2.6.29/ && do_things

cd linux_sph-d700/Kernel/ && do_things
