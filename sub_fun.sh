#!/bin/bash
set -e

#current patch for review is cloned to ext/pita so need to checkout correct version of superproject for this patch

#check to see if this has been run before (not a clean build)
if [ ! -d .git ]; then
	git init
fi

if ! git remote show origin >/dev/null 2>/dev/null; then
    git remote add origin ssh://git@origin/superproject
fi

if ! git remote show gerrit >/dev/null 2>/dev/null; then
    git remote add gerrit ssh://build@gerrit:29418/superproject
fi

git fetch gerrit
git fetch gerrit --tags
git fetch origin
git fetch origin --tags
git log -1 --pretty=oneline

git checkout `cat ext/pitpita/superproject-hash`
git reset --hard

#step through the modules to update all except the one that started this all
declare -a modules
modules=($(awk -F "=" '/path/ {print $2}' .gitmodules))
for submodule in "${modules[@]}"
do
	if [ $submodule = "ext/pita" ]; then
		#do nothing
		echo "Not updating ext/pita"
	else
		git submodule update --init --recursive $submodule
	fi
done

