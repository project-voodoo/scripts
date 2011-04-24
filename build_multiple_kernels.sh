#!/bin/bash

show()
{
	echo -e "\n  * $1\n"
}

show "Galaxy S GT-I9000 Froyo"
./scripts/build_kernel.sh

show "Nexus S"
./scripts/nexuss_build_kernel.sh

show "Galaxy S CM7"
./scripts/cm7_galaxys_build_kernel.sh

#show "Galaxy S Gingerbread leak"
#./scripts/gingerbread_leak_galaxys_build_kernel.sh

show "Galaxy S GT-I9000 Gingerbread"
./scripts/sgs_gb_build_kernel.sh

show "Galaxy S GT-I9000 Eclair"
cd linux_gt-i9000-eclair
nice -n 20 bash ./build_kernel.sh
cd - > /dev/null

show "Galaxy Tab Verizon"
cd /home/curio/dev/voodoo/linux_sch-i800/Kernel
nice -n 20 make -j6
cd - > /dev/null

show "Fascinate Eclair"
cd linux_sch-i500
nice -n 20 bash ./build_kernel.sh
cd - > /dev/null

show "Epic4G Froyo"
cd linux_sph-d700
nice -n 20 bash ./build_kernel.sh
cd - > /dev/null

show "Epic4G Eclair"
cd linux_sph-d700-eclair
nice -n 20 bash ./build_kernel.sh
cd - > /dev/null

show "Captivate Froyo"
cd linux_sgh-i897
nice -n 20 make -j8
cd - > /dev/null

show "Vibrant Froyo"
cd linux_sgh-t959
nice -n 20 make -j8
cd - > /dev/null

show "Vibrant 4G Froyo"
cd linux_sgh-t959v
nice -n 20 make -j8
cd - > /dev/null

show "M110S Froyo"
cd linux_shw-m110s
nice -n 20 make -j8
cd - > /dev/null

