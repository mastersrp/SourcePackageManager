#!/bin/bash

[[ "$PAKLIB_ROOT" == "" ]] && export PAKLIB_ROOT=$(pwd -P)/.spm/paklib

build_type=$( echo "conf = dofile '../paklib/utils/conf.lua'
print( conf.get( 'BUILD_TYPE', '../tup.config' ) ) " | lua -)

printf "[ type -> $build_type ]\n"

if [[ "$build_type" == "minimal" ]]; then
	cp -fu spm-minimal.sh.in spm.sh
	exit 0
fi

# Ensure that .spm/ exists before trying to write to it
mkdir -p .spm/bin
mkdir -p .spm/paklib/lib

tup_root=$( echo "conf = dofile '../paklib/utils/conf.lua'
print( conf.get( 'DIR_TUP_ROOT', '../tup.config' ) ) " | lua -)
[[ ! -e "../${tup_root}" ]] && exit 1

# Copy the required files into .spm
printf " * Creating .spm archive ...";
if [[ "$build_type" == "standalone" ]]; then
	cp -f ../src/spm .spm/bin/spm
	cp -f ../${tup_root}/tup .spm/bin/tup
fi
cp -rf ../paklib/ .spm/
find .spm/paklib/ -iname '*.swp' -delete
printf "[DONE]\n";

# Archive .spm into spm.tgz and add the payload to the shell script
printf " * Creating spm.tar.bz2...";
tar -cf spm.tar .spm/
bzip2 -9 spm.tar
[[ "$build_type" == "standalone" ]] && cp -fu spm.sh.in spm.sh
[[ "$build_type" == "lite" ]] && cp -fu spm-lite.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
base64 spm.tar.bz2 >> spm.sh
printf "[DONE]\n";

# Remember to clean up after ourselves
printf " * Cleaning up....";
rm -Rf spm.tar.bz2 .spm/
printf "[DONE]\n";
