#!/bin/bash

# Ensure that .spm/ exists before trying to write to it.
mkdir -p .spm/
cp -f ../src/spm .spm/spm
cp -f ../deps/tinycc/tcc .spm/tcc
cp -f ../deps/tup/tup .spm/tup
cp -Rf ../paklib/ .spm/paklib/
tar -czf spm.tgz .spm/
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
cat spm.tgz >> spm.sh
rm -Rf spm.tgz .spm/
