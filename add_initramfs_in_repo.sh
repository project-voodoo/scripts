#!/bin/sh

if ! test -n "$2"; then
	exit 1
fi

./kernel_repack_utils/extracter.sh -s $1 -d $2

cd $2 || exit 1
../scripts/write_froyo_gitignores.sh
git add .
git commit
git push
