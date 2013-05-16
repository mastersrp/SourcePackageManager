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

if [[ "$lua_installed" == "0" ]]; then
	lua scripts/getdeps.lua pull
	[[ ! "$?" == "0" ]] && exit 1
else
	printf "[!] You'll need lua installed to compile this project!\n"
	exit 1
fi

if [[ ! -s "build/tup.config" ]]; then
	printf "" > build/tup.config

	echo "CONFIG_DEBUG=n" >> build/tup.config
	echo "CONFIG_CC=gcc" >> build/tup.config
	echo "CONFIG_AR=ar rcu" >> build/tup.config
	echo "CONFIG_BUILD_TYPE=standalone" >> build/tup.config
	lua scripts/getdeps.lua configure
fi

export PATH=${CWD}:$PATH

TUP=$(which tup);
if [[ ! -e "$TUP" ]]; then
	printf "Building tup...\n" | tee .spm/log -a;
	cd ${CWD}/deps/tup;
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
	[[ -s "build/scripts/spm.sh" ]] && cp -vfu build/scripts/spm.sh bin/spm
	echo "export PATH=$(pwd -P)/bin:\$PATH" > scripts/spm
fi
