#!/bin/bash

# Ensure that .spm/ exists before trying to write to it.
mkdir -p .spm/paklib/include
cp -f ../src/spm .spm/spm
cp -f ../src/libspm.a .spm/paklib/
cp -f ../deps/tinycc/tcc .spm/tcc
cp -f ../deps/tinycc/lib/libtcc1.a .spm/paklib/include/
cp -Rf ../deps/tinycc/include .spm/paklib/
cp -f ../deps/tup/tup .spm/tup
cp -Rf ../paklib/ .spm/
tar -czf spm.tgz .spm/
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
cat spm.tgz >> spm.sh
rm -Rf spm.tgz .spm/
