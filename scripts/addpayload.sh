#!/bin/bash

# Ensure that .spm/ exists before trying to write to it
mkdir -p .spm/paklib/include/spm
mkdir -p .spm/bin
mkdir -p .spm/paklib/lib

# Copy the required files into .spm
cp -f ../src/spm .spm/bin/spm
cp -f ../src/libspm.a .spm/paklib/lib/
cp -f ../deps/tinycc/tcc .spm/bin/tcc
cp -f ../deps/tinycc/lib/libtcc1.a .spm/paklib/include/
cp -Rf ../deps/tinycc/include/* .spm/paklib/include/
cp -f ../src/{spm,log}.h .spm/paklib/include/spm/
cp -f ../deps/tup/tup .spm/bin/tup
cp -Rf ../paklib/ .spm/

# Archive .spm into spm.tgz and add the payload to the shell script
tar -cf spm.tar .spm/
bzip2 -9 spm.tar
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
cat spm.tar.bz2 >> spm.sh

# Remember to clean up after ourselves
rm -Rf spm.tar.bz2 .spm/
