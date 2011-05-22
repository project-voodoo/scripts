#!/bin/sh

if ! test -n "$2"; then
	exit 1
fi

./kernel_repack_utils/extracter.sh -s $1 -d $2

cd $2 || exit 1
touch system/.gitignore proc/.gitignore dev/.gitignore sys/.gitignore data/.gitignore
git add .
git commit
git push
