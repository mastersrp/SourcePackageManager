#!/bin/bash
CWD=$(pwd -P)
mkdir -p ${CWD}/.spm/
REPO=file://${HOME}/work/tuprepo

# Parameters for getpack are (category)/(package) (base_package_name) (tag/branch)
# Note that remote tags can be fetched running
# `git ls-remote --tags (remote_url)`
function getpack {
	git clone ${REPO}/${1}.build ${CWD}/deps/${2}.build --single-branch --branch ${3} | tee .spm/log -a;
	git clone ${REPO}/${1} ${CWD}/deps/${2} --single-branch --branch ${3} | tee .spm/log -a;
	cp -Rf ${CWD}/deps/${2}.build/* ${CWD}/deps/${2};
	rm -Rf ${CWD}/deps/${2}.build/;
}
if [ ! -d "deps/lua" ]; then
	printf "Fetching dev-lang/lua v5.2.1 from repos...\n" | tee .spm/log -a;
	getpack dev-lang/lua lua v5.2.1;
fi
if [ ! -d "deps/tinycc" ]; then
	printf "Fetching dev-lang/tinycc release_0_9_26 from repos...\n" | tee .spm/log -a;
	getpack dev-lang/tinycc tinycc release_0_9_26;
fi
if [ ! -d "deps/tup" ]; then
	printf "Fetching dev-util/tup v0.6 from upstream...\n" | tee .spm/log -a;
	git clone git://github.com/gittup/tup.git deps/tup --single-branch --branch v0.6 | tee .spm/log -a;
fi
if [ ! -d "deps/musl" ]; then
	printf "Fetching sys-libs/musl v0.9.9 from repos...\n" | tee .spm/log -a;
	getpack sys-libs/musl musl v0.9.9;
fi
# Commented out for internal testing and review
#if [ ! -d "deps/libgit2" ]; then
#	printf "Fetching dev-libs/libgit2 v0.17.0 from upstream...\n" | tee .spm/log -a;
#	getpack dev-libs/libgit2 libgit2 v0.17.0
#fi
TUP=$(which tup);
if [ ! -e $TUP ]; then
	printf "Building tup...\n" | tee .spm/log -a;
	cd ${CWD}/deps/tup;
	./bootstrap.sh;
	cp -Rf {.tup,tup} ${CWD};
	cd ${CWD};
	TUP=${PWD}/tup;
	rm -Rf;
fi
if [ ! -d ".tup" ]; then
	$TUP init;
fi
$TUP upd;
