#!/bin/sh

set -x

export LOCALVERSION="-I9000XXJVO-CL182937"
export KBUILD_BUILD_VERSION="Voodoo"

cd linux_shw-m110s-gingerbread/
nice -n 10 make -j8 $*
