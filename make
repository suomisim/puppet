#!/bin/bash

echo -n "Module name: "

read HANDLE

mkdir $HANDLE

mkdir $HANDLE/manifests/
mkdir $HANDLE/templates/
touch $HANDLE/manifests/init.pp

echo "class $HANDLE { }" >> $HANDLE/manifests/init.pp
