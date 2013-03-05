#!/bin/bash

mkdir -p .spm/
cp -f ../src/spm .spm/spm
cp -Rf ../paklib/ .spm/paklib/
tar -czf spm.tgz .spm/
cp -f spm.sh.in spm.sh
echo "PAYLOAD:" >> spm.sh
cat spm.tgz >> spm.sh
rm -Rf spm.tgz .spm/
