#!/bin/sh

adb reboot download&
scripts/sgs_gb_build_kernel.sh
scripts/sgs_gb_flash-heimdall.sh
