#!/bin/bash

if [ $# != 1 ]
	then echo "Please provide exactly one argument, the desired macro name."
	exit 
fi

NAME=$1


SHORT_TAG=`git describe --tag --abbrev=0`
LONG_TAG=`git describe --tags --long`

#echo $SHORT_TAG
echo "milliqanOffline version $LONG_TAG"

sed "s/shorttagplaceholder/$SHORT_TAG/g" simple_macro.C > make_tree_temporary_for_compile.C
sed -i "s/longtagplaceholder/$LONG_TAG/g" make_tree_temporary_for_compile.C

#g++ -o $NAME make_tree_temporary_for_compile.C /net/cms26/cms26r0/milliqan/milliDAQ/libMilliDAQ.so `root-config --cflags --glibs` -Wno-narrowing  

g++ -o $NAME make_tree_temporary_for_compile.C /home/milliqan/MilliDAQ/src/ConfigurationReader.cc /home/milliqan/MilliDAQ/libMilliDAQ.so -lpython2.7 `root-config --cflags --glibs` -Wno-narrowing  # same as above but with correct local file path
if [ $? -eq 0 ]; then
    echo "Compiled macro $NAME"
else
    echo "FAILED to compile macro $NAME"
fi
rm make_tree_temporary_for_compile.C


