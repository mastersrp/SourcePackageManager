#!/bin/bash

# Ensure that .spm/ exists before trying to write to it.
mkdir -p .spm/paklib/include/spm
mkdir -p .spm/bin
cp -f ../src/spm .spm/bin/spm
cp -f ../src/libspm.a .spm/paklib/
cp -f ../deps/tinycc/tcc .spm/bin/tcc
cp -f ../deps/tinycc/lib/libtcc1.a .spm/paklib/include/
cp -Rf ../deps/tinycc/include/* .spm/paklib/include/
cp -f ../src/*.h .spm/paklib/include/spm/
cp -f ../deps/tup/tup .spm/bin/tup
cp -Rf ../paklib/ .spm/
tar -czf spm.tgz .spm/
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
cat spm.tgz >> spm.sh
rm -Rf spm.tgz .spm/
