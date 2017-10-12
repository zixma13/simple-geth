#!/bin/bash

# in/out files
configFile=./myown.properties
vagrantOrig=./Vagrantfile.orig
vagrantOut=./Vagrantfile

# input file exist ?
if [ ! -f $configFile ]; then echo "failed"; exit 1; fi;
if [ ! -f $vagrantOrig ]; then echo "failed"; exit 1; fi;

# cp vagrant
cp $vagrantOrig $vagrantOut

# loop config and replace output file
while IFS='' read -r line || [[ -n "$line" ]]
do
  key=`echo $line| awk -F= '{print $1}'`
  val=`echo $line| awk -F= '{print $2}'`
  sed -i "s|$key|$val|g" $vagrantOut
done < $configFile

echo "success"
exit 0


