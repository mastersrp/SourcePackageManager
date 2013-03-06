#!/bin/bash
CWD=$(pwd -P)
mkdir -p ${CWD}/.spm/
REPO=file://${HOME}/work/tuprepo

# Parameters for getpack are (category)/(package) (base_package_name) (tag/branch)
# Note that remote tags can be fetched running
# `git ls-remote --tags (remote_url)`
function updateall {
	for DEPS in $(find deps/ -maxdepth 1 -mindepth 1 -type d); do
		REMOTE=$(cat .spm/deps | cut -d " " -f 1)/$(cat .spm/deps | cut -d " " -f 2).build;
		LOCAL=deps/$(cat .spm/deps | cut -d " " -f 3);
		REVISION=$(cat .spm/deps | cut -d " " -f 4);
		LOCAL_HASH=$(cat .spm/deps | cut -d " " -f 5);
		REMOTE_HASH=$(git ls-remote --heads ${REMOTE} | grep ${REVISION})
		REMOTE_HASH=${REMOTE_HASH:0:40}
		if [[ $REMOTE_HASH == $LOCAL_HASH ]]; then
			printf "$DEPS is up to date!\n";
		else
			printf "$DEPS is out of date! Updating...\n";
			cd ${CWD}/$LOCAL;
			git reset --hard HEAD;
			cd ${CWD};
			git clone $REMOTE ${CWD}/$LOCAL --single-branch --branch $REVISION | tee .spm/log -a;
			cp -Rf ${LOCAL}.build/* ${LOCAL}/;
			rm -Rf ${LOCAL}.build;
		fi
	done
}
function getpack {
	git clone ${REPO}/${1}.build ${CWD}/deps/${2}.build --single-branch --branch ${3} | tee .spm/log -a;
	REVISION_HASH=$(git ls-remote --heads ${REPO}/${1}.build | grep ${3})
	printf "$REVISION_HASH\n";
	REVISION_HASH=${REVISION_HASH:0:40}
	printf "$REVISION_HASH\n";
	git clone ${REPO}/${1} ${CWD}deps/${2} --single-branch --branch ${3} | tee .spm/log -a;
	cp -Rf deps/${2}.build/* deps/${2};
	rm -Rf deps/${2}.build/;
	if [[ ! -e ".spm/deps" || $(cat .spm/deps | grep ${1}) == "" ]]; then
		echo "${REPO} ${1} ${2} ${3} ${REVISION_HASH}" >> .spm/deps
	fi
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
updateall
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
