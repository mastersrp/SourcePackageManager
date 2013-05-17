#!/bin/bash

# Ensure that .spm/ exists before trying to write to it
mkdir -p .spm/paklib/include/spm
mkdir -p .spm/bin
mkdir -p .spm/paklib/lib

# Copy the required files into .spm
printf " * Creating .spm archive ...";
cp -f ../src/spm .spm/bin/spm
cp -f ../deps/tup/tup .spm/bin/tup
cp -rf ../paklib/ .spm/
find .spm/paklib/ -iname '*.swp' -delete
printf "[DONE]\n";

# Archive .spm into spm.tgz and add the payload to the shell script
printf " * Creating spm.tar.bz2...";
tar -cf spm.tar .spm/
bzip2 -9 spm.tar
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
base64 spm.tar.bz2 >> spm.sh
printf "[DONE]\n";

# Remember to clean up after ourselves
printf " * Cleaning up....";
rm -Rf spm.tar.bz2 .spm/
printf "[DONE]\n";
