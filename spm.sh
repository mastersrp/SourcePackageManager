#!/bin/bash

[[ "$PAKLIB_ROOT" == "" ]] && export PAKLIB_ROOT=$(pwd -P)/paklib

export LUA_PATH=${PAKLIB_ROOT}/?.lua
install -d build/
install -d .spm
lua ${PAKLIB_ROOT}/main.lua $@
exit $?
