#!/bin/bash

# Ensure that .spm/ exists before trying to write to it
mkdir -p .spm/paklib/include/spm
mkdir -p .spm/bin
mkdir -p .spm/paklib/lib

# Copy the required files into .spm
printf " * Creating .spm archive ...";
cp -f ../src/spm .spm/bin/spm
cp -f ../src/libspm.a .spm/paklib/lib/
cp -f ../deps/tinycc/tcc .spm/bin/tcc
cp -f ../deps/tinycc/lib/libtcc1.a .spm/paklib/include/
cp -Rf ../deps/tinycc/include/* .spm/paklib/include/
cp -f ../src/{spm,log}.h .spm/paklib/include/spm/
cp -f ../deps/tup/tup .spm/bin/tup
cp -Rf ../paklib/* .spm/paklib/
printf "[DONE]\n";

# Compile .moon files to .lua
for MOON in $(find .spm/paklib -type f -iname '*.moon'); do
	printf " * Compiling $MOON to ${MOON:0:-5}.lua...";
	moonc $MOON >/dev/null;
	if [[ ! "$?" == "0" ]]; then
		printf "[FAIL]\n";
	else
		printf "[DONE]\n";
	fi
	#luac -o ${MOON:0:-5}.luac ${MOON:0:-5}.lua
	#rm -f ${MOON:0:-5}.lua
done

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
