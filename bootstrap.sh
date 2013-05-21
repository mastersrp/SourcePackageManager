#!/bin/bash

for arg in $@; do
	[[ "$arg" == "-v" || "$arg" == "--verbose" ]] && verbose=true
done
CWD=$(pwd -P)
install -d ${CWD}/.spm/
install -d ${CWD}/build
install -d ${CWD}/bin

which lua &>/dev/null
lua_installed=$?

export LUA_PATH=$(pwd -P)/paklib/?.lua
export PAKLIB_ROOT=$(pwd -P)/paklib

if [[ "$lua_installed" == "0" ]]; then
	lua paklib/main.lua clone
	[[ ! "$?" == "0" ]] && exit 1
else
	printf "[!] You'll need lua installed to compile this project!\n"
	exit 1
fi

echo "conf = dofile 'paklib/utils/conf.lua'
conf.update( 'DEBUG','n' )
conf.update( 'CC', 'gcc' )
conf.update( 'AR', 'ar rcu' )
conf.update( 'BUILD_TYPE', 'standalone' )" | lua -
[[ ! "$?" == "0" ]] && exit 1
lua paklib/main.lua configure
[[ ! "$?" == "0" ]] && exit 1

if [[ -x "{CWD}/tup" ]]; then
	TUP=${CWD}/tup
else
	TUP=$(which tup);
fi
if [[ ! -e "$TUP" ]]; then
	printf "Building tup...\n" | tee .spm/log -a;
	tup_root = $(echo "conf = dofile 'paklib/utils/conf.lua'
	print( conf.get( 'TUP_ROOT' ) )" | lua -)
	cd ${CWD}/${tup_root}
	./bootstrap.sh;
	cp -vf {.tup,tup} ${CWD};
	rm -vf {.tup,tup};
	for m in $(find . -iname '*.o' -or -iname '*.a'); do rm -rvf $m; done
	cd ${CWD};
	TUP=${PWD}/tup;
fi
cd ${CWD}
if [ ! -d ".tup" ]; then
	$TUP init;
fi
if [[ "$verbose" ]]; then
	$TUP upd --verbose;
else
	$TUP upd;
fi

if [[ "$?" == "0" ]]; then
	echo "export PATH=$(pwd -P)/bin:\$PATH" > scripts/spm
fi
