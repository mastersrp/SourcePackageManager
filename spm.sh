#!/bin/bash

[[ "$SPM_ROOT" == "" ]] && export SPM_ROOT=$(pwd -P)
[[ "$PAKLIB_ROOT" == "" ]] && export PAKLIB_ROOT=${SPM_ROOT}/paklib

export LUA_PATH=${PAKLIB_ROOT}/?.lua
install -d build/
install -d .spm
lua ${PAKLIB_ROOT}/main.lua $@
exit $?
